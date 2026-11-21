Add-Type -AssemblyName System.Drawing

# Let's crop sample thumbnails from LVHQ0663.JPG and tu.JPG to see what they are
$bmpTu = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot\..\tu.JPG")
Write-Host "tu.JPG pixel (0,0): $($bmpTu.GetPixel(0,0))"
$bmpTu.Dispose()

$bmpLvhq = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot\..\LVHQ0663.JPG")
Write-Host "LVHQ0663.JPG pixel (0,0): $($bmpLvhq.GetPixel(0,0))"
$bmpLvhq.Dispose()
