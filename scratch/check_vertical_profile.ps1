Add-Type -AssemblyName System.Drawing
$img = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot\..\graduation_files\tu-polaroid-centered.jpg")
Write-Host "tu-polaroid-centered size: $($img.Width) x $($img.Height)"
for ($y = 20; $y -lt 1000; $y += 40) {
    $c = $img.GetPixel(400, $y)
    $tag = ""
    if ($c.R -gt 150 -and $c.G -gt 100 -and $c.B -gt 80 -and ($c.R - $c.B) -gt 20) {
        $tag = "[SKIN/FACE]"
    } elseif ($c.R -lt 40 -and $c.G -lt 40 -and $c.B -lt 40) {
        $tag = "[BLACK - CAP/GOWN]"
    } elseif ($c.R -gt 150 -and $c.G -gt 150) {
        $tag = "[LIGHT/BG]"
    }
    Write-Host ("Y={0:D3}: R={1:D3}, G={2:D3}, B={3:D3} {4}" -f $y, $c.R, $c.G, $c.B, $tag)
}
$img.Dispose()
