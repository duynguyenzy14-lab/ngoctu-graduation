Add-Type -AssemblyName System.Drawing

$srcPath = "$PSScriptRoot\..\LVHQ0663.JPG"
$dstPath = "$PSScriptRoot\..\graduation_files\tu-polaroid-centered.jpg"

$src = [System.Drawing.Bitmap]::FromFile($srcPath)

# Crop box: X = 1350, Y = 350, Width = 2400, Height = 3000 (Exact 4:5 ratio)
$cropRect = New-Object System.Drawing.Rectangle(1350, 350, 2400, 3000)

# Target resolution: 800 x 1000 (sharp, fast loading, perfect 4:5)
$targetWidth = 800
$targetHeight = 1000

$dst = New-Object System.Drawing.Bitmap($targetWidth, $targetHeight)
$g = [System.Drawing.Graphics]::FromImage($dst)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality

$dstRect = New-Object System.Drawing.Rectangle(0, 0, $targetWidth, $targetHeight)
$g.DrawImage($src, $dstRect, $cropRect, [System.Drawing.GraphicsUnit]::Pixel)

# Save with high quality JPEG (92%)
$encoder = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
$encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
$encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]92)

$dst.Save($dstPath, $encoder, $encoderParams)

$g.Dispose()
$dst.Dispose()
$src.Dispose()

Write-Host "Created centered polaroid portrait: $dstPath (800 x 1000)"
