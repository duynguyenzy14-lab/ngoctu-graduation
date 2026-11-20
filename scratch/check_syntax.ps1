$html = [System.IO.File]::ReadAllText("$PSScriptRoot\..\index.html")
$css = [System.IO.File]::ReadAllText("$PSScriptRoot\..\style.css")

$openBraces = ($css.ToCharArray() | Where-Object { $_ -eq '{' }).Count
$closeBraces = ($css.ToCharArray() | Where-Object { $_ -eq '}' }).Count

Write-Host "HTML size: $($html.Length) chars"
Write-Host "CSS size: $($css.Length) chars"
Write-Host "CSS Braces: { = $openBraces, } = $closeBraces"

if ($openBraces -eq $closeBraces) {
    Write-Host "CSS Braces match perfectly!" -ForegroundColor Green
} else {
    Write-Host "WARNING: CSS Braces mismatch!" -ForegroundColor Red
}
