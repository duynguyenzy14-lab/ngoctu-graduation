$js = [System.IO.File]::ReadAllText("graduation_files\app.js.tải xuống", [System.Text.Encoding]::UTF8)

$openBraces = ($js.ToCharArray() | Where-Object { $_ -eq '{' }).Count
$closeBraces = ($js.ToCharArray() | Where-Object { $_ -eq '}' }).Count
$openParens = ($js.ToCharArray() | Where-Object { $_ -eq '(' }).Count
$closeParens = ($js.ToCharArray() | Where-Object { $_ -eq ')' }).Count

Write-Host "JS Braces: $openBraces / $closeBraces"
Write-Host "JS Parens: $openParens / $closeParens"
if ($openBraces -eq $closeBraces -and $openParens -eq $closeParens) {
    Write-Host "JS Balance: PERFECT MATCH!"
} else {
    Write-Error "JS Balance mismatch!"
}
