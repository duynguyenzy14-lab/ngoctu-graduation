Add-Type -AssemblyName System.Drawing

$src = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot\..\LVHQ0663.JPG")
$upright = New-Object System.Drawing.Bitmap($src)
$upright.RotateFlip([System.Drawing.RotateFlipType]::Rotate90FlipNone)
$src.Dispose()

Write-Host "Upright dimensions: $($upright.Width) x $($upright.Height)"

# Crop coordinates:
# Width = 3500 (Center X = 1824 -> Left X = 74, Right X = 3574)
# Height = 4375 (4:5 ratio: 3500 * 5 / 4 = 4375)
# Y: 320 to 4695
$cropX = 74
$cropY = 320
$cropW = 3500
$cropH = 4375

$cropRect = New-Object System.Drawing.Rectangle($cropX, $cropY, $cropW, $cropH)

# Target resolution: 800 x 1000 (perfect crisp HD, fast mobile load)
$targetW = 800
$targetH = 1000

$dst = New-Object System.Drawing.Bitmap($targetW, $targetH)
$g = [System.Drawing.Graphics]::FromImage($dst)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality

$dstRect = New-Object System.Drawing.Rectangle(0, 0, $targetW, $targetH)
$g.DrawImage($upright, $dstRect, $cropRect, [System.Drawing.GraphicsUnit]::Pixel)

$encoder = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
$encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
$encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]95)

$outPath = "$PSScriptRoot\..\graduation_files\tu-polaroid-centered.jpg"
$dst.Save($outPath, $encoder, $encoderParams)

Write-Host "Successfully generated perfect upright centered polaroid photo: $outPath"

$g.Dispose()
$dst.Dispose()
$upright.Dispose()
