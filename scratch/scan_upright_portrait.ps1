Add-Type -AssemblyName System.Drawing

$src = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot\..\LVHQ0663.JPG")
$img = New-Object System.Drawing.Bitmap($src)
$img.RotateFlip([System.Drawing.RotateFlipType]::Rotate90FlipNone)
$src.Dispose()

Write-Host "Upright dimensions: $($img.Width) x $($img.Height)" # 3648 x 5472

# 1. Let's find top of the black cap along X = 1824
$capTopY = -1
for ($y = 100; $y -lt 2000; $y += 20) {
    $c = $img.GetPixel(1824, $y)
    if ($c.R -lt 60 -and $c.G -lt 60 -and $c.B -lt 60) {
        $capTopY = $y
        break
    }
}
Write-Host "Cap top Y (center): $capTopY"

# 2. Let's scan horizontal bounds of cap and face around Y = 1000 and Y = 2000
$faceLeftX = -1
$faceRightX = -1
for ($x = 400; $x -lt 3200; $x += 20) {
    $c = $img.GetPixel($x, 2000)
    $isSkin = ($c.R -gt 150 -and $c.G -gt 100 -and $c.B -gt 80 -and ($c.R - $c.B) -gt 20)
    if ($isSkin -and $faceLeftX -eq -1) { $faceLeftX = $x }
    if ($isSkin) { $faceRightX = $x }
}
Write-Host "Face at Y=2000: Left X = $faceLeftX, Right X = $faceRightX, Center X = $((($faceLeftX + $faceRightX) / 2))"

# 3. Let's check face bottom (chin)
$chinY = -1
for ($y = 2000; $y -lt 3500; $y += 20) {
    $c = $img.GetPixel(1824, $y)
    $isSkin = ($c.R -gt 150 -and $c.G -gt 100 -and $c.B -gt 80 -and ($c.R - $c.B) -gt 20)
    if (-not $isSkin) {
        $chinY = $y
        break
    }
}
Write-Host "Chin / neck transition Y: $chinY"

$img.Dispose()
