# validate_v12.ps1
$ErrorActionPreference = "Stop"

$js = Get-Content -Path "script.js" -Raw -Encoding UTF8

$errors = @()

if ($js -notmatch 'CLOUD_GUESTBOOK_API') {
  $errors += "Missing CLOUD_GUESTBOOK_API in script.js"
}
if ($js -notmatch 'fetchCloudWishes') {
  $errors += "Missing fetchCloudWishes in script.js"
}
if ($js -notmatch 'ngoctung2188@gmail\.com\.vn') {
  $errors += "Missing ngoctung2188@gmail.com.vn in script.js"
}

$jsOpen = ($js.ToCharArray() | Where-Object { $_ -eq '{' }).Count
$jsClose = ($js.ToCharArray() | Where-Object { $_ -eq '}' }).Count
if ($jsOpen -ne $jsClose) {
  $errors += "JS brace mismatch: $jsOpen open vs $jsClose close"
}

if ($errors.Count -eq 0) {
  Write-Host "SUCCESS: ALL CHECKS PASSED FOR V12!" -ForegroundColor Green
  Write-Host "JS Open: $jsOpen, JS Close: $jsClose"
} else {
  Write-Host "FAILURES FOUND:" -ForegroundColor Red
  $errors | ForEach-Object { Write-Host " - $_" -ForegroundColor Red }
}
