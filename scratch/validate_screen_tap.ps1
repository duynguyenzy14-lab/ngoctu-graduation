# validate_screen_tap.ps1
$ErrorActionPreference = "Stop"

$js = Get-Content -Path "script.js" -Raw -Encoding UTF8

$errors = @()

if ($js -notmatch 'CHẠM VÀO NỬA TRÁI / PHẢI MÀN HÌNH') {
  $errors += "Missing screen tap flip logic in script.js"
}
if ($js -notmatch 'clickX >= screenWidth / 2') {
  $errors += "Missing clickX logic in script.js"
}

$jsOpen = ($js.ToCharArray() | Where-Object { $_ -eq '{' }).Count
$jsClose = ($js.ToCharArray() | Where-Object { $_ -eq '}' }).Count
if ($jsOpen -ne $jsClose) {
  $errors += "JS brace mismatch: $jsOpen vs $jsClose"
}

if ($errors.Count -eq 0) {
  Write-Host "SUCCESS: Script.js validated with screen tap flip logic!" -ForegroundColor Green
  Write-Host "Open: $jsOpen, Close: $jsClose"
} else {
  Write-Host "FAILURES:" -ForegroundColor Red
  $errors | ForEach-Object { Write-Host " - $_" -ForegroundColor Red }
}
