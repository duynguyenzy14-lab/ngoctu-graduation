Add-Type -AssemblyName System.Drawing

$src = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot\..\LVHQ0663.JPG")
$upright = New-Object System.Drawing.Bitmap($src)
$upright.RotateFlip([System.Drawing.RotateFlipType]::Rotate90FlipNone)
$src.Dispose()

Write-Host "Upright: $($upright.Width) x $($upright.Height)"

# Let's check subject bounds across all Y from 800 to 4500
$overallMinX = 9999
$overallMaxX = -1

for ($y = 800; $y -lt 4500; $y += 50) {
    for ($x = 50; $x -lt 3600; $x += 15) {
        $c = $upright.GetPixel($x, $y)
        # Background is white/light or pale foliage
        $isBg = ($c.R -gt 225 -and $c.G -gt 225 -and $c.B -gt 225) -or ($c.G -gt 170 -and $c.G -gt $c.R -and $c.G -gt $c.B)
        if (-not $isBg) {
            if ($x -lt $overallMinX) { $overallMinX = $x }
            if ($x -gt $overallMaxX) { $overallMaxX = $x }
        }
    }
}

Write-Host "Overall subject spans X: $overallMinX .. $overallMaxX"
$subjectCenter = [int](($overallMinX + $overallMaxX) / 2)
$subjectWidth = $overallMaxX - $overallMinX
Write-Host "Subject width: $subjectWidth, Subject Center: $subjectCenter"

# Cap width at Y=1000:
$capMinX = 9999; $capMaxX = -1
for ($x = 50; $x -lt 3600; $x += 10) {
    $c = $upright.GetPixel($x, 1000)
    if ($c.R -lt 50 -and $c.G -lt 50 -and $c.B -lt 50) {
        if ($x -lt $capMinX) { $capMinX = $x }
        if ($x -gt $capMaxX) { $capMaxX = $x }
    }
}
Write-Host "Cap at Y=1000 spans X: $capMinX .. $capMaxX (Center: $((($capMinX+$capMaxX)/2)))"

# Face width at Y=1800:
$faceMinX = 9999; $faceMaxX = -1
for ($x = 50; $x -lt 3600; $x += 10) {
    $c = $upright.GetPixel($x, 1800)
    $isSkin = ($c.R -gt 150 -and $c.G -gt 100 -and $c.B -gt 80 -and ($c.R - $c.B) -gt 20)
    if ($isSkin) {
        if ($x -lt $faceMinX) { $faceMinX = $x }
        if ($x -gt $faceMaxX) { $faceMaxX = $x }
    }
}
Write-Host "Face at Y=1800 spans X: $faceMinX .. $faceMaxX (Center: $((($faceMinX+$faceMaxX)/2)))"

$upright.Dispose()
