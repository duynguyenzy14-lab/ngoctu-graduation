Add-Type -AssemblyName System.Drawing

$lvhq = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot\..\LVHQ0663.JPG")

# Inspect row Y=1900 (Face row)
$faceXs = @()
for ($x = 1000; $x -lt 4500; $x += 20) {
    $c = $lvhq.GetPixel($x, 1900)
    if ($c.R -gt 180 -and $c.G -gt 140 -and $c.B -gt 110) {
        $faceXs += $x
    }
}
$minFaceX = ($faceXs | Measure-Object -Minimum).Minimum
$maxFaceX = ($faceXs | Measure-Object -Maximum).Maximum
Write-Host "Face at Y=1900: X between $minFaceX and $maxFaceX (center: $([int](($minFaceX+$maxFaceX)/2)))"

# Inspect cap at Y=1000
$capXs = @()
for ($x = 1000; $x -lt 4500; $x += 20) {
    $c = $lvhq.GetPixel($x, 1000)
    if ($c.R -lt 60 -and $c.G -lt 60 -and $c.B -lt 60) {
        $capXs += $x
    }
}
$minCapX = ($capXs | Measure-Object -Minimum).Minimum
$maxCapX = ($capXs | Measure-Object -Maximum).Maximum
Write-Host "Cap at Y=1000: X between $minCapX and $maxCapX (center: $([int](($minCapX+$maxCapX)/2)))"

$lvhq.Dispose()
