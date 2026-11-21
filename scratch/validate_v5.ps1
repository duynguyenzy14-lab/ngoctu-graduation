# validate_v5.ps1
$ErrorActionPreference = "Stop"

$html = Get-Content -Path "index.html" -Raw -Encoding UTF8
$css = Get-Content -Path "style.css" -Raw -Encoding UTF8
$js = Get-Content -Path "script.js" -Raw -Encoding UTF8

$errors = @()

# 1. Check HTML
if ($html -match 'corner-page-curl') { $errors += "HTML still contains corner-page-curl" }
if ($html -match 'maps\.google\.com|goo\.gl') { $errors += "HTML still contains Google Maps link" }
if ($html -notmatch 'Lật sang trang nha') { $errors += "HTML missing 'Lật sang trang nha'" }
if ($html -notmatch 'Số 97 Võ Văn Tần, Phường Xuân Hòa, TP\. Hồ Chí Minh') { $errors += "HTML missing updated address" }
if ($html -notmatch 'Trang trước') { $errors += "HTML missing 'Trang trước'" }
if ($html -notmatch 'Trang tiếp theo') { $errors += "HTML missing 'Trang tiếp theo'" }
if ($html -notmatch 'id="page5"') { $errors += "HTML missing Page 5" }
if ($html -notmatch 'id="rsvpForm"') { $errors += "HTML missing rsvpForm" }

# Check pre-grad photos in filmstrip
$preGradPhotos = @(
  "lvhq0003-800.jpg", "lvhq0066-800.jpg", "lvhq0101-800.jpg", "lvhq0321-800.jpg",
  "lvhq0336-800.jpg", "lvhq0357-800.jpg", "lvhq0513-800.jpg", "lvhq0556-800.jpg",
  "lvhq0638-800.jpg", "lvhq0655-800.jpg", "lvhq0660-800.jpg", "lvhq0673-800.jpg",
  "lvhq0783-800.jpg", "lvhq0799-800.jpg", "lvhq9982-800.jpg", "lvhq9987-800.jpg"
)
foreach ($p in $preGradPhotos) {
  if ($html -notmatch $p) {
    $errors += "HTML missing photo $p"
  }
}

# 2. Check CSS
if ($css -notmatch '\.letter-paragraph\.highlight-msg\s*\{[^}]*font-style:\s*normal') {
  $errors += "CSS highlight-msg does not have font-style: normal"
}
if ($css -notmatch 'rollFilmStrip 85s') {
  $errors += "CSS rollFilmStrip is not 85s"
}
if ($css -notmatch '\.rsvp-card') {
  $errors += "CSS missing .rsvp-card"
}

# Check CSS braces matching
$openBraces = ($css.ToCharArray() | Where-Object { $_ -eq '{' }).Count
$closeBraces = ($css.ToCharArray() | Where-Object { $_ -eq '}' }).Count
if ($openBraces -ne $closeBraces) {
  $errors += "CSS brace mismatch: $openBraces open vs $closeBraces close"
}

# 3. Check JS
if ($js -notmatch 'targetPage > 5') {
  $errors += "JS targetPage boundary should be 5"
}
if ($js -notmatch 'formsubmit\.co') {
  $errors += "JS missing formsubmit endpoint"
}
$jsOpenBraces = ($js.ToCharArray() | Where-Object { $_ -eq '{' }).Count
$jsCloseBraces = ($js.ToCharArray() | Where-Object { $_ -eq '}' }).Count
if ($jsOpenBraces -ne $jsCloseBraces) {
  $errors += "JS brace mismatch: $jsOpenBraces open vs $jsCloseBraces close"
}

if ($errors.Count -eq 0) {
  Write-Host "ALL CHECKS PASSED PERFECTLY!" -ForegroundColor Green
  Write-Host "Total film items in track: $((Select-String -Path index.html -Pattern 'film-frame-item').Count)"
} else {
  Write-Host "ERRORS FOUND:" -ForegroundColor Red
  $errors | ForEach-Object { Write-Host " - $_" -ForegroundColor Red }
}
