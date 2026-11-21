Add-Type -AssemblyName System.Drawing

$fontFamilies = @("Playfair Display", "Georgia", "Times New Roman", "Arial")
foreach ($ff in $fontFamilies) {
    try {
        $font = New-Object System.Drawing.Font($ff, 12, [System.Drawing.FontStyle]::Bold)
        $bmp = New-Object System.Drawing.Bitmap(500, 100)
        $g = [System.Drawing.Graphics]::FromImage($bmp)
        $sizeText = $g.MeasureString("MEMORIES", $font)
        $sizeYear = $g.MeasureString("2022 - 2026", $font)
        Write-Host "$ff : 'MEMORIES' H=$($sizeText.Height) W=$($sizeText.Width) | '2022-2026' H=$($sizeYear.Height) W=$($sizeYear.Width)"
        $g.Dispose()
        $bmp.Dispose()
        $font.Dispose()
    } catch {
        Write-Host "$ff not installed locally"
    }
}
