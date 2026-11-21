Add-Type -AssemblyName System.Drawing
# Compare aspect ratios and file details
$tu = [System.Drawing.Image]::FromFile("$PSScriptRoot\..\tu.JPG")
$lvhq = [System.Drawing.Image]::FromFile("$PSScriptRoot\..\LVHQ0663.JPG")
$port = [System.Drawing.Image]::FromFile("$PSScriptRoot\..\graduation_files\lvhq0663-portrait.jpg")

Write-Host "tu.JPG: $($tu.Width) x $($tu.Height)"
Write-Host "LVHQ0663: $($lvhq.Width) x $($lvhq.Height)"
Write-Host "portrait: $($port.Width) x $($port.Height)"

$tu.Dispose()
$lvhq.Dispose()
$port.Dispose()
