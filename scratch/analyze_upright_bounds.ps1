Add-Type -AssemblyName System.Drawing

$src = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot\..\LVHQ0663.JPG")
$img = New-Object System.Drawing.Bitmap($src)
$img.RotateFlip([System.Drawing.RotateFlipType]::Rotate90FlipNone)
$src.Dispose()

Write-Host "Width = $($img.Width), Height = $($img.Height)"

# Let's find cap top:
$capTop = 740

# Let's find bottom of diploma / hands:
# Scanning at Y=3800..5200 for where gown or hands end
for ($y = 3500; $y -lt 5400; $y += 50) {
    $c = $img.GetPixel(1824, $y)
    Write-Host ("Y={0:D4}: R={1:D3}, G={2:D3}, B={3:D3}" -f $y, $c.R, $c.G, $c.B)
}

$img.Dispose()
