# scratch/generate_full_polaroid.ps1
Add-Type -AssemblyName System.Drawing

$src = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot\..\LVHQ0663.JPG")
$upright = New-Object System.Drawing.Bitmap($src)
$upright.RotateFlip([System.Drawing.RotateFlipType]::Rotate90FlipNone)
$src.Dispose()

Write-Host "Upright full dimensions: $($upright.Width) x $($upright.Height)"

# Rescale FULL uncropped upright photo to 800 x 1200 (exact 2:3 ratio of 3648 x 5472)
$targetW = 800
$targetH = 1200

$dst = New-Object System.Drawing.Bitmap($targetW, $targetH)
$g = [System.Drawing.Graphics]::FromImage($dst)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality

$dstRect = New-Object System.Drawing.Rectangle(0, 0, $targetW, $targetH)
$srcRect = New-Object System.Drawing.Rectangle(0, 0, $upright.Width, $upright.Height)
$g.DrawImage($upright, $dstRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)

$encoder = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
$encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
$encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]95)

$outPath = "$PSScriptRoot\..\graduation_files\tu-polaroid-full.jpg"
$dst.Save($outPath, $encoder, $encoderParams)

Write-Host "Successfully generated full uncropped photo: $outPath"

$g.Dispose()
$dst.Dispose()
$upright.Dispose()
