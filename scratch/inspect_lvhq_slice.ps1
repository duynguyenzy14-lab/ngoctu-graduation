Add-Type -AssemblyName System.Drawing

$lvhq = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot\..\LVHQ0663.JPG")
Write-Host "LVHQ0663 size: $($lvhq.Width) x $($lvhq.Height)"

# Let's inspect vertical slice in center around X = 2500 - 3000
for ($y = 0; $y -lt 3600; $y += 200) {
    $c = $lvhq.GetPixel(2600, $y)
    Write-Host "Y=$y : R=$($c.R), G=$($c.G), B=$($c.B)"
}
$lvhq.Dispose()
