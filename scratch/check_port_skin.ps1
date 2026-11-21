Add-Type -AssemblyName System.Drawing

$port = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot\..\graduation_files\lvhq0663-portrait.jpg")
Write-Host "lvhq0663-portrait: $($port.Width) x $($port.Height)"

$skin = @()
for ($y = 0; $y -lt $port.Height; $y += 10) {
    for ($x = 0; $x -lt $port.Width; $x += 10) {
        $c = $port.GetPixel($x, $y)
        if ($c.R -gt 160 -and $c.G -gt 110 -and $c.B -gt 80 -and $c.R -gt $c.G -and $c.G -gt $c.B -and ($c.R - $c.B) -gt 25) {
            $skin += [PSCustomObject]@{X = $x; Y = $y}
        }
    }
}
if ($skin.Count -gt 0) {
    $minY = ($skin | Measure-Object -Property Y -Minimum).Minimum
    $maxY = ($skin | Measure-Object -Property Y -Maximum).Maximum
    $avgX = [int](($skin | Measure-Object -Property X -Average).Average)
    $avgY = [int](($skin | Measure-Object -Property Y -Average).Average)
    Write-Host "Portrait skin: X avg $avgX / $($port.Width), Y between $minY and $maxY (avg $avgY / $($port.Height))"
}
$port.Dispose()
