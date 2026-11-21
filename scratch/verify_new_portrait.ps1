Add-Type -AssemblyName System.Drawing
$img = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot\..\graduation_files\tu-polaroid-centered.jpg")
Write-Host "tu-polaroid-centered: $($img.Width) x $($img.Height)"
# Y=0.15 (Headroom/cap top)
$c1 = $img.GetPixel(400, 150)
Write-Host "Y=0.15 (Center): R=$($c1.R), G=$($c1.G), B=$($c1.B)"
# Y=0.35 (Face)
$c2 = $img.GetPixel(400, 350)
Write-Host "Y=0.35 (Face): R=$($c2.R), G=$($c2.G), B=$($c2.B)"
# Y=0.7 (Gown / Diploma)
$c3 = $img.GetPixel(400, 700)
Write-Host "Y=0.7 (Gown): R=$($c3.R), G=$($c3.G), B=$($c3.B)"
$img.Dispose()
