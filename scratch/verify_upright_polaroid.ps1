Add-Type -AssemblyName System.Drawing

$img = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot\..\graduation_files\tu-polaroid-centered.jpg")
Write-Host "New tu-polaroid-centered.jpg: $($img.Width) x $($img.Height)"

Write-Host "--- Scanning Vertical Centerline (X = 400) ---"
for ($y = 20; $y -lt 1000; $y += 40) {
    $c = $img.GetPixel(400, $y)
    $tag = ""
    if ($c.R -gt 150 -and $c.G -gt 100 -and $c.B -gt 80 -and ($c.R - $c.B) -gt 20) {
        $tag = "[SKIN/FACE]"
    } elseif ($c.R -lt 45 -and $c.G -lt 45 -and $c.B -lt 45) {
        $tag = "[DARK - CAP/GOWN]"
    } elseif ($c.R -gt 200 -and $c.G -gt 200 -and $c.B -gt 200) {
        $tag = "[BRIGHT/BG/LACE]"
    }
    Write-Host ("Y={0:D3}: R={1:D3}, G={2:D3}, B={3:D3} {4}" -f $y, $c.R, $c.G, $c.B, $tag)
}

Write-Host "--- Scanning Across Face (Y = 350) ---"
$faceMinX = -1; $faceMaxX = -1
for ($x = 50; $x -lt 750; $x += 10) {
    $c = $img.GetPixel($x, 350)
    $isSkin = ($c.R -gt 150 -and $c.G -gt 100 -and $c.B -gt 80 -and ($c.R - $c.B) -gt 20)
    if ($isSkin) {
        if ($faceMinX -eq -1) { $faceMinX = $x }
        $faceMaxX = $x
    }
}
Write-Host "Face at Y=350 spans X=$faceMinX..$faceMaxX, Center=$((($faceMinX+$faceMaxX)/2)) (Target is 400)"

$img.Dispose()
