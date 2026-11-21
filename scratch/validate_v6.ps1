# validate_v6.ps1
$ErrorActionPreference = "Stop"

$html = Get-Content -Path "index.html" -Raw -Encoding UTF8
$css = Get-Content -Path "style.css" -Raw -Encoding UTF8
$js = Get-Content -Path "script.js" -Raw -Encoding UTF8

$errors = @()

# 1. Check all 6 pages exist
1..6 | ForEach-Object {
  if ($html -notmatch "id=`"page$_`"") {
    $errors += "Missing page $_ in index.html"
  }
}

# 2. Check interleaved film track
$bgCount = ([regex]::Matches($html, 'bg-pics/pic-')).Count
$pgCount = ([regex]::Matches($html, 'photos/lvhq')).Count
Write-Host "HTML bg-pics occurrences: $bgCount"
Write-Host "HTML pre-grad photos occurrences: $pgCount"
if ($bgCount -ne 40) { $errors += "Expected 40 bg-pics (20 x 2), found $bgCount" }
if ($pgCount -ne 32) { $errors += "Expected 32 pre-grad photos (16 x 2), found $pgCount" }

# 3. Check "Tên của bạn:"
if ($html -notmatch 'Tên của bạn:') { $errors += "Missing 'Tên của bạn:' in Page 5" }
if ($html -match 'Tên của bạn / Người thương:') { $errors += "Old label 'Tên của bạn / Người thương:' still present" }

# 4. Check "LỄ TỐT NGHIỆP ĐẠI HỌC 2026" color
if ($css -notmatch '\.details-main-title\s*\{[^}]*color:\s*var\(--pink-accent\)') {
  $errors += "details-main-title is not var(--pink-accent)"
}

# 5. Check Page 6 content: "Hẹn gặp người thương" and "28/11/2026"
if ($html -notmatch 'Hẹn gặp người thương') { $errors += "Missing 'Hẹn gặp người thương' in HTML" }
if ($html -notmatch '28/11/2026') { $errors += "Missing '28/11/2026' in HTML" }
if ($html -notmatch 'id="wishesList"') { $errors += "Missing wishesList container in HTML" }

# 6. Check JS braces and functions
$jsOpen = ($js.ToCharArray() | Where-Object { $_ -eq '{' }).Count
$jsClose = ($js.ToCharArray() | Where-Object { $_ -eq '}' }).Count
Write-Host "JS Open Braces: $jsOpen, Close Braces: $jsClose"
if ($jsOpen -ne $jsClose) { $errors += "JS brace mismatch: $jsOpen vs $jsClose" }

if ($js -notmatch 'targetPage > 6') { $errors += "JS targetPage boundary should be 6" }
if ($js -notmatch 'flipToPageFn\(6\)') { $errors += "JS missing auto-flip to Page 6 on form submit" }

# 7. Check CSS braces
$cssOpen = ($css.ToCharArray() | Where-Object { $_ -eq '{' }).Count
$cssClose = ($css.ToCharArray() | Where-Object { $_ -eq '}' }).Count
Write-Host "CSS Open Braces: $cssOpen, Close Braces: $cssClose"
if ($cssOpen -ne $cssClose) { $errors += "CSS brace mismatch: $cssOpen vs $cssClose" }

if ($errors.Count -eq 0) {
  Write-Host "SUCCESS: ALL CHECKS PASSED FOR V6!" -ForegroundColor Green
} else {
  Write-Host "FAILURES FOUND:" -ForegroundColor Red
  $errors | ForEach-Object { Write-Host " - $_" -ForegroundColor Red }
}
