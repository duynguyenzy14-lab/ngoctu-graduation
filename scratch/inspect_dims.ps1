Add-Type -AssemblyName System.Drawing

# Let's check how lvhq0663-portrait.jpg looks
$port = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot\..\graduation_files\lvhq0663-portrait.jpg")
Write-Host "lvhq0663-portrait.jpg: $($port.Width) x $($port.Height)"

# Let's check tu.JPG
$tu = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot\..\tu.JPG")
Write-Host "tu.JPG: $($tu.Width) x $($tu.Height)"

# Let's check tu-800.jpg
$tu800 = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot\..\tu-800.jpg")
Write-Host "tu-800.jpg: $($tu800.Width) x $($tu800.Height)"

$port.Dispose()
$tu.Dispose()
$tu800.Dispose()
