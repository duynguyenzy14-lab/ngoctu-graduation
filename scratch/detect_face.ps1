Add-Type -AssemblyName System.Drawing

$lvhq = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot\..\LVHQ0663.JPG")
Write-Host "LVHQ0663 full size: $($lvhq.Width) x $($lvhq.Height)"

# Let's see where the skin tones / face are in LVHQ0663
# We can search for the face region: skin tone in RGB roughly R > 150, G > 100, B > 80, R > G, G > B
$skinPixels = @()
for ($y = 500; $y -lt 3000; $y += 50) {
    for ($x = 1000; $x -lt 4500; $x += 50) {
        $c = $lvhq.GetPixel($x, $y)
        if ($c.R -gt 160 -and $c.G -gt 110 -and $c.B -gt 80 -and $c.R -gt $c.G -and $c.G -gt $c.B -and ($c.R - $c.B) -gt 25) {
            $skinPixels += [PSCustomObject]@{X = $x; Y = $y}
        }
    }
}

if ($skinPixels.Count -gt 0) {
    $minX = ($skinPixels | Measure-Object -Property X -Minimum).Minimum
    $maxX = ($skinPixels | Measure-Object -Property X -Maximum).Maximum
    $minY = ($skinPixels | Measure-Object -Property Y -Minimum).Minimum
    $maxY = ($skinPixels | Measure-Object -Property Y -Maximum).Maximum
    $avgX = [int](($skinPixels | Measure-Object -Property X -Average).Average)
    $avgY = [int](($skinPixels | Measure-Object -Property Y -Average).Average)
    Write-Host "Skin cluster: X between $minX and $maxX (avg $avgX), Y between $minY and $maxY (avg $avgY)"
} else {
    Write-Host "No skin cluster detected"
}

$lvhq.Dispose()
