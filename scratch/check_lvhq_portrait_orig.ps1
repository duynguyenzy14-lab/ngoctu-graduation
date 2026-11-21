Add-Type -AssemblyName System.Drawing

$img = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot\..\graduation_files\lvhq0663-portrait.jpg")
Write-Host "lvhq0663-portrait.jpg: $($img.Width) x $($img.Height)"
for ($y = 50; $y -lt 800; $y += 50) {
    $c = $img.GetPixel(266, $y)
    $tag = ""
    if ($c.R -gt 150 -and $c.G -gt 100 -and $c.B -gt 80 -and ($c.R - $c.B) -gt 20) {
        $tag = "[SKIN]"
    } elseif ($c.R -lt 40 -and $c.G -lt 40 -and $c.B -lt 40) {
        $tag = "[DARK - CAP/GOWN]"
    } elseif ($c.R -gt 160 -and $c.G -gt 160) {
        $tag = "[LIGHT/BG]"
    }
    Write-Host ("Y={0:D3}: R={1:D3}, G={2:D3}, B={3:D3} {4}" -f $y, $c.R, $c.G, $c.B, $tag)
}
$img.Dispose()
