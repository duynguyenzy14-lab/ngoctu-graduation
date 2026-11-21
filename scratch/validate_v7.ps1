# validate_v7.ps1
$ErrorActionPreference = "Stop"

$html = Get-Content -Path "index.html" -Raw -Encoding UTF8
$css = Get-Content -Path "style.css" -Raw -Encoding UTF8
$js = Get-Content -Path "script.js" -Raw -Encoding UTF8

$errors = @()

# 1. HTML checks
if ($html -match 'DẤU MỐC THANH XUÂN') {
  $errors += "'DẤU MỐC THANH XUÂN' still present in index.html"
}
if ($html -notmatch 'trong thanh xuân của Ngọc Tú ♡') {
  $errors += "Missing 'trong thanh xuân của Ngọc Tú ♡' in index.html"
}
if ($html -notmatch 'publicWishCheckbox') {
  $errors += "Missing publicWishCheckbox in index.html"
}
if ($html -notmatch 'id="wishesViewport"') {
  $errors += "Missing wishesViewport in index.html"
}

1..6 | ForEach-Object {
  if ($html -notmatch "id=`"page$_`"") {
    $errors += "Missing page $_ in index.html"
  }
}

# 2. CSS checks
if ($css -notmatch '\.farewell-main-title\s*\{[^}]*font-weight:\s*500') {
  $errors += "farewell-main-title font-weight is not 500"
}
if ($css -notmatch 'scrollWishesVertical') {
  $errors += "Missing scrollWishesVertical keyframe in style.css"
}

$cssOpen = ($css.ToCharArray() | Where-Object { $_ -eq '{' }).Count
$cssClose = ($css.ToCharArray() | Where-Object { $_ -eq '}' }).Count
if ($cssOpen -ne $cssClose) {
  $errors += "CSS brace mismatch: $cssOpen open vs $cssClose close"
}

# 3. JS checks
if ($js -notmatch 'DEFAULT_WISHES\s*=\s*\[\s*\]') {
  $errors += "DEFAULT_WISHES should be empty []"
}
if ($js -notmatch 'isContentInappropriate') {
  $errors += "Missing isContentInappropriate filter function in script.js"
}
if ($js -notmatch 'publicWishCheckbox') {
  $errors += "Missing publicWishCheckbox logic in script.js"
}

$jsOpen = ($js.ToCharArray() | Where-Object { $_ -eq '{' }).Count
$jsClose = ($js.ToCharArray() | Where-Object { $_ -eq '}' }).Count
if ($jsOpen -ne $jsClose) {
  $errors += "JS brace mismatch: $jsOpen vs $jsClose"
}

if ($errors.Count -eq 0) {
  Write-Host "SUCCESS: ALL CHECKS PASSED FOR V7!" -ForegroundColor Green
  Write-Host "CSS Open Braces: $cssOpen, Close Braces: $cssClose"
  Write-Host "JS Open Braces: $jsOpen, Close Braces: $jsClose"
} else {
  Write-Host "FAILURES FOUND:" -ForegroundColor Red
  $errors | ForEach-Object { Write-Host " - $_" -ForegroundColor Red }
}
