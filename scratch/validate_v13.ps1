# validate_v13.ps1
$ErrorActionPreference = "Stop"

$html = Get-Content -Path "index.html" -Raw -Encoding UTF8
$css = Get-Content -Path "style.css" -Raw -Encoding UTF8
$js = Get-Content -Path "script.js" -Raw -Encoding UTF8

$errors = @()

# 1. HTML
if ($html -notmatch 'wishesSecretTrigger') { $errors += "Missing wishesSecretTrigger in index.html" }
if ($html -notmatch 'adminModalOverlay') { $errors += "Missing adminModalOverlay in index.html" }
if ($html -notmatch 'adminPinInput') { $errors += "Missing adminPinInput in index.html" }

# 2. CSS
if ($css -notmatch '\.admin-modal-overlay') { $errors += "Missing .admin-modal-overlay in style.css" }
$cssOpen = ($css.ToCharArray() | Where-Object { $_ -eq '{' }).Count
$cssClose = ($css.ToCharArray() | Where-Object { $_ -eq '}' }).Count
if ($cssOpen -ne $cssClose) { $errors += "CSS brace mismatch: $cssOpen vs $cssClose" }

# 3. JS
if ($js -notmatch 'initAdminPanel') { $errors += "Missing initAdminPanel in script.js" }
if ($js -notmatch '2811') { $errors += "Missing default PIN 2811 in script.js" }
$jsOpen = ($js.ToCharArray() | Where-Object { $_ -eq '{' }).Count
$jsClose = ($js.ToCharArray() | Where-Object { $_ -eq '}' }).Count
if ($jsOpen -ne $jsClose) { $errors += "JS brace mismatch: $jsOpen vs $jsClose" }

if ($errors.Count -eq 0) {
  Write-Host "SUCCESS: ALL CHECKS PASSED FOR V13 SECURITY & ADMIN SYSTEM!" -ForegroundColor Green
  Write-Host "CSS Braces: $cssOpen, JS Braces: $jsOpen"
} else {
  Write-Host "FAILURES FOUND:" -ForegroundColor Red
  $errors | ForEach-Object { Write-Host " - $_" -ForegroundColor Red }
}
