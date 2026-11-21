# validate_v10.ps1
$ErrorActionPreference = "Stop"

$html = Get-Content -Path "index.html" -Raw -Encoding UTF8
$css = Get-Content -Path "style.css" -Raw -Encoding UTF8
$js = Get-Content -Path "script.js" -Raw -Encoding UTF8

$errors = @()

# 1. HTML checks
if ($html -match 'khoảnh khắc đáng nhớ nhé ♡') {
  $errors += "'nhé' still present in letter in index.html"
}
if ($html -notmatch 'khoảnh khắc đáng nhớ ♡') {
  $errors += "Missing updated 'khoảnh khắc đáng nhớ ♡' in index.html"
}
if ($html -match 'rsvp-badge') {
  $errors += "rsvp-badge still present in index.html"
}
if ($html -match 'radio-emoji') {
  $errors += "radio-emoji still present in index.html"
}

# 2. JS checks
if ($js -match 'khoảnh khắc đáng nhớ nhé ♡') {
  $errors += "'nhé' still present in script.js"
}
if ($js -match 'Sẽ đến nhaa! 💖') {
  $errors += "Emoji still present in attendingText in script.js"
}

$jsOpen = ($js.ToCharArray() | Where-Object { $_ -eq '{' }).Count
$jsClose = ($js.ToCharArray() | Where-Object { $_ -eq '}' }).Count
if ($jsOpen -ne $jsClose) {
  $errors += "JS brace mismatch: $jsOpen vs $jsClose"
}

# 3. CSS checks
$cssOpen = ($css.ToCharArray() | Where-Object { $_ -eq '{' }).Count
$cssClose = ($css.ToCharArray() | Where-Object { $_ -eq '}' }).Count
if ($cssOpen -ne $cssClose) {
  $errors += "CSS brace mismatch: $cssOpen vs $cssClose"
}

if ($errors.Count -eq 0) {
  Write-Host "SUCCESS: ALL CHECKS PASSED FOR V10!" -ForegroundColor Green
  Write-Host "CSS Open: $cssOpen, JS Open: $jsOpen"
} else {
  Write-Host "FAILURES FOUND:" -ForegroundColor Red
  $errors | ForEach-Object { Write-Host " - $_" -ForegroundColor Red }
}
