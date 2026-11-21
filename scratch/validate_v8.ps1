# validate_v8.ps1
$ErrorActionPreference = "Stop"

$html = Get-Content -Path "index.html" -Raw -Encoding UTF8
$css = Get-Content -Path "style.css" -Raw -Encoding UTF8
$js = Get-Content -Path "script.js" -Raw -Encoding UTF8

$errors = @()

# 1. HTML checks
if ($html -notmatch 'A little moments to remember ♡') {
  $errors += "Missing 'A little moments to remember ♡' in index.html"
}
if ($html -match 'đáng nhớ nhé! ♡') {
  $errors += "Exclamation mark still in letter in index.html"
}

# 2. CSS checks
if ($css -notmatch '\.photo-container\s*\{[^}]*aspect-ratio:\s*2/3') {
  $errors += "photo-container aspect-ratio is not 2/3"
}
if ($css -notmatch '\.letter-place-date\s*\{[^}]*font-style:\s*normal') {
  $errors += "letter-place-date font-style is not normal"
}
if ($css -notmatch '\.letter-signature\s*\{[^}]*font-size:\s*clamp\(16px') {
  $errors += "letter-signature font-size is not updated smaller"
}
if ($css -notmatch '\.farewell-main-title\s*\{[^}]*font-weight:\s*700') {
  $errors += "farewell-main-title font-weight is not 700 (bold)"
}

$cssOpen = ($css.ToCharArray() | Where-Object { $_ -eq '{' }).Count
$cssClose = ($css.ToCharArray() | Where-Object { $_ -eq '}' }).Count
if ($cssOpen -ne $cssClose) {
  $errors += "CSS brace mismatch: $cssOpen open vs $cssClose close"
}

# 3. JS checks
if ($js -match 'đáng nhớ nhé! ♡') {
  $errors += "Exclamation mark still in script.js GUEST_DATA"
}
if ($js -notmatch 'collapsedKeywords') {
  $errors += "Enhanced anti-hater filter not found in script.js"
}

$jsOpen = ($js.ToCharArray() | Where-Object { $_ -eq '{' }).Count
$jsClose = ($js.ToCharArray() | Where-Object { $_ -eq '}' }).Count
if ($jsOpen -ne $jsClose) {
  $errors += "JS brace mismatch: $jsOpen vs $jsClose"
}

if ($errors.Count -eq 0) {
  Write-Host "SUCCESS: ALL CHECKS PASSED FOR V8!" -ForegroundColor Green
  Write-Host "CSS Braces: $cssOpen, JS Braces: $jsOpen"
} else {
  Write-Host "FAILURES FOUND:" -ForegroundColor Red
  $errors | ForEach-Object { Write-Host " - $_" -ForegroundColor Red }
}
