Add-Type -AssemblyName System.Drawing

$src = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot\..\LVHQ0663.JPG")
$img = New-Object System.Drawing.Bitmap($src)
$img.RotateFlip([System.Drawing.RotateFlipType]::Rotate90FlipNone)
$src.Dispose()

Write-Host "--- Scanning Lower Half (Y=2000..5400) along X=1824 and X=1400, 2200 ---"
for ($y = 2000; $y -le 5400; $y += 200) {
    $cMid = $img.GetPixel(1824, $y)
    $cLeft = $img.GetPixel(1200, $y)
    $cRight = $img.GetPixel(2400, $y)
    Write-Host ("Y={0:D4} | Mid: R={1:D3},G={2:D3},B={3:D3} | Left: R={4:D3},G={5:D3},B={6:D3} | Right: R={7:D3},G={8:D3},B={9:D3}" -f `
        $y, $cMid.R, $cMid.G, $cMid.B, $cLeft.R, $cLeft.G, $cLeft.B, $cRight.R, $cRight.G, $cRight.B)
}

$img.Dispose()
