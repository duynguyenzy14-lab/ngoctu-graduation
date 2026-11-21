Add-Type -AssemblyName System.Drawing

$src = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot\..\LVHQ0663.JPG")
Write-Host "Raw size: $($src.Width) x $($src.Height)"

# Let's inspect what happens if we apply Rotate90FlipNone
$img90 = New-Object System.Drawing.Bitmap($src)
$img90.RotateFlip([System.Drawing.RotateFlipType]::Rotate90FlipNone)
Write-Host "After Rotate90: $($img90.Width) x $($img90.Height)" # should be 3648 x 5472

# In an upright portrait of 3648 x 5472:
# Top (Y=200..1000) should be background/cap
# Middle (Y=1200..2500) should be face/cap
# Lower (Y=2800..5000) should be gown/body
# Let's test colors along centerline X = 1824
for ($y = 400; $y -lt 5400; $y += 400) {
    $c = $img90.GetPixel(1824, $y)
    $tag = ""
    if ($c.R -gt 150 -and $c.G -gt 100 -and $c.B -gt 80 -and ($c.R - $c.B) -gt 20) {
        $tag = "[SKIN]"
    } elseif ($c.R -lt 40 -and $c.G -lt 40 -and $c.B -lt 40) {
        $tag = "[DARK - CAP/GOWN]"
    } elseif ($c.R -gt 160 -and $c.G -gt 160) {
        $tag = "[LIGHT/BG]"
    }
    Write-Host ("Y={0:D4}: R={1:D3}, G={2:D3}, B={3:D3} {4}" -f $y, $c.R, $c.G, $c.B, $tag)
}

$img90.Dispose()
$src.Dispose()
