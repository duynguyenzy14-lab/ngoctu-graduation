Add-Type -AssemblyName System.Drawing

function Sample-Grid($path, $name) {
    $bmp = [System.Drawing.Bitmap]::FromFile($path)
    Write-Host "=== $name ($($bmp.Width) x $($bmp.Height)) ==="
    $w = $bmp.Width
    $h = $bmp.Height
    # Sample 5 points horizontally and vertically
    for ($y = 0.2; $y -le 0.8; $y += 0.2) {
        $row = ""
        for ($x = 0.2; $x -le 0.8; $x += 0.2) {
            $px = [int]($x * $w)
            $py = [int]($y * $h)
            $col = $bmp.GetPixel($px, $py)
            $row += "($([int]$col.R),$([int]$col.G),$([int]$col.B)) "
        }
        Write-Host "Y=$([math]::Round($y,1)): $row"
    }
    $bmp.Dispose()
}

Sample-Grid "$PSScriptRoot\..\tu-800.jpg" "tu-800"
Sample-Grid "$PSScriptRoot\..\graduation_files\lvhq0663-portrait.jpg" "lvhq0663-portrait"
