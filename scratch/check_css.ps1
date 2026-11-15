$css = [System.IO.File]::ReadAllText("graduation_files\style.css", [System.Text.Encoding]::UTF8)

$openBraces = ($css.ToCharArray() | Where-Object { $_ -eq '{' }).Count
$closeBraces = ($css.ToCharArray() | Where-Object { $_ -eq '}' }).Count

Write-Host "CSS Open braces: $openBraces, Close braces: $closeBraces"
if ($openBraces -eq $closeBraces) {
    Write-Host "CSS Bracket Balance: PERFECT MATCH!"
} else {
    Write-Error "CSS Bracket mismatch!"
}
