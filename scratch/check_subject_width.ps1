Add-Type -AssemblyName System.Drawing

$src = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot\..\LVHQ0663.JPG")
$img = New-Object System.Drawing.Bitmap($src)
$img.RotateFlip([System.Drawing.RotateFlipType]::Rotate90FlipNone)
$src.Dispose()

Write-Host "Upright: $($img.Width) x $($img.Height)"

foreach ($scanY in @(800, 1200, 1600, 2000, 2500, 3000, 3500, 4000)) {
    $minX = -1; $maxX = -1
    for ($x = 100; $x -lt 3548; $x += 20) {
        $c = $img.GetPixel($x, $scanY)
        # Check if pixel is subject (not bright white/green background)
        $isBg = ($c.R -gt 220 -and $c.G -gt 220 -and $c.B -gt 220) -or ($c.G -gt 160 -and $c.G -gt $c.R -and $c.G -gt $c.B)
        if (-not $isBg) {
            if ($minX -eq -1) { $minX = $x }
            $maxX = $x
        }
    }
    Write-Host ("Y={0:D4}: Subject X = {1:D4} .. {2:D4} (W={3:D4}, Center={4:D4})" -f `
        $scanY, $minX, $maxX, ($maxX - $minX), ([int](($minX + $maxX) / 2)))
}

$img.Dispose()
