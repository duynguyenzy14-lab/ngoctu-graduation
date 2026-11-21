$html = [System.IO.File]::ReadAllText("$PSScriptRoot\..\index.html")
$css = [System.IO.File]::ReadAllText("$PSScriptRoot\..\style.css")
$js = [System.IO.File]::ReadAllText("$PSScriptRoot\..\script.js")

Write-Host "index.html length: $($html.Length)"
Write-Host "style.css length: $($css.Length)"
Write-Host "script.js length: $($js.Length)"

$cssOpen = ([regex]::Matches($css, '\{')).Count
$cssClose = ([regex]::Matches($css, '\}')).Count
Write-Host "CSS braces: Open=$cssOpen, Close=$cssClose"

$jsOpen = ([regex]::Matches($js, '\{')).Count
$jsClose = ([regex]::Matches($js, '\}')).Count
Write-Host "JS braces: Open=$jsOpen, Close=$jsClose"

# Check required keywords
$checkItems = @(
    "A little moment to remember ♡",
    "The Graduation Day of",
    "NGUYỄN NGỌC TÚ",
    "QUẢN LÝ CÔNG",
    "BỐN NĂM, THẬT NHIỀU KHOẢNH KHẮC TẠI OU",
    "▶ QUẢN LÝ CÔNG",
    "GRADUATION",
    "J3IRYx3PzzM"
)

foreach ($item in $checkItems) {
    if ($html.Contains($item) -or $js.Contains($item)) {
        Write-Host "[OK] Found: $item"
    } else {
        Write-Host "[MISSING] Not found: $item"
    }
}
