Add-Type -AssemblyName System.Drawing

$src = "C:\Users\Tu Nguyen\OneDrive\Documents\GitHub\ngoctu-graduation\graduation_files\lvhq0663-800.jpg"
$dst = "C:\Users\Tu Nguyen\OneDrive\Documents\GitHub\ngoctu-graduation\graduation_files\lvhq0663-portrait.jpg"

$img = [System.Drawing.Image]::FromFile($src)
Write-Host ("Original: " + $img.Width + "x" + $img.Height)

# Rotate 90 degrees clockwise => landscape becomes portrait
$img.RotateFlip([System.Drawing.RotateFlipType]::Rotate90FlipNone)
Write-Host ("After rotate: " + $img.Width + "x" + $img.Height)

$ep = New-Object System.Drawing.Imaging.EncoderParameters(1)
$ep.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, 90L)
$codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
$img.Save($dst, $codec, $ep)
$img.Dispose()

Write-Host ("Saved portrait photo to: " + $dst)
