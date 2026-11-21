Add-Type -AssemblyName System.Drawing
$imgPath = "C:\Users\Tu Nguyen\.gemini\antigravity\brain\b7930d6f-f794-44be-a7c4-f47bb58aece3\.user_uploaded\media_1795184346922_d8c01e63.png"
if (Test-Path $imgPath) {
    $img = [System.Drawing.Image]::FromFile($imgPath)
    Write-Host "Uploaded image 1: $($img.Width) x $($img.Height)"
    $img.Dispose()
} else {
    Write-Host "Image 1 not found"
}
