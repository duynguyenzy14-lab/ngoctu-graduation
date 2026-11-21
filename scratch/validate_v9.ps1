# validate_v9.ps1
$ErrorActionPreference = "Stop"

$html = Get-Content -Path "index.html" -Raw -Encoding UTF8
$css = Get-Content -Path "style.css" -Raw -Encoding UTF8
$js = Get-Content -Path "script.js" -Raw -Encoding UTF8

$errors = @()

# 1. Check Polaroid corners
if ($css -notmatch '\.polaroid-inner\s*\{[^}]*border-radius:\s*0;') {
  $errors += "polaroid-inner border-radius is not 0"
}
if ($css -notmatch '\.photo-container\s*\{[^}]*border-radius:\s*0;') {
  $errors += "photo-container border-radius is not 0"
}

# 2. Check caption text size and weight
if ($css -notmatch '\.polaroid-caption-text\s*\{[^}]*font-size:\s*clamp\(12px') {
  $errors += "polaroid-caption-text font-size is not clamp(12px...)"
}
if ($css -notmatch '\.polaroid-caption-text\s*\{[^}]*font-weight:\s*400;') {
  $errors += "polaroid-caption-text font-weight is not 400"
}

# 3. Check btn-flip-page font-weight 500
if ($css -notmatch '\.btn-flip-page\s*\{[^}]*font-weight:\s*500;') {
  $errors += "btn-flip-page font-weight is not 500"
}

# 4. Check CSS braces
$cssOpen = ($css.ToCharArray() | Where-Object { $_ -eq '{' }).Count
$cssClose = ($css.ToCharArray() | Where-Object { $_ -eq '}' }).Count
if ($cssOpen -ne $cssClose) {
  $errors += "CSS brace mismatch: $cssOpen open vs $cssClose close"
}

# 5. Check JS braces
$jsOpen = ($js.ToCharArray() | Where-Object { $_ -eq '{' }).Count
$jsClose = ($js.ToCharArray() | Where-Object { $_ -eq '}' }).Count
if ($jsOpen -ne $jsClose) {
  $errors += "JS brace mismatch: $jsOpen vs $jsClose"
}

if ($errors.Count -eq 0) {
  Write-Host "SUCCESS: ALL CHECKS PASSED FOR V9!" -ForegroundColor Green
  Write-Host "CSS Open: $cssOpen, CSS Close: $cssClose"
  Write-Host "JS Open: $jsOpen, JS Close: $jsClose"
} else {
  Write-Host "FAILURES FOUND:" -ForegroundColor Red
  $errors | ForEach-Object { Write-Host " - $_" -ForegroundColor Red }
}
