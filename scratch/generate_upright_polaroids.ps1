Add-Type -AssemblyName System.Drawing

$src = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot\..\LVHQ0663.JPG")
$upright = New-Object System.Drawing.Bitmap($src)
$upright.RotateFlip([System.Drawing.RotateFlipType]::Rotate90FlipNone)
$src.Dispose()

Write-Host "Upright bitmap loaded: $($upright.Width) x $($upright.Height)"

# Let's create Option A: 4:5 ratio (800 x 1000)
# X: 184 to 3464 (Width = 3280)
# Y: 350 to 4450 (Height = 4100)
# Ratio = 3280 / 4100 = 0.8 (4:5)
$targetW = 800
$targetH = 1000

$cropA = New-Object System.Drawing.Rectangle(184, 350, 3280, 4100)
$dstA = New-Object System.Drawing.Bitmap($targetW, $targetH)
$gA = [System.Drawing.Graphics]::FromImage($dstA)
$gA.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$gA.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$gA.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$gA.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
$dstRect = New-Object System.Drawing.Rectangle(0, 0, $targetW, $targetH)
$gA.DrawImage($upright, $dstRect, $cropA, [System.Drawing.GraphicsUnit]::Pixel)

$encoder = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
$encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
$encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]95)

$outPath = "$PSScriptRoot\..\graduation_files\tu-polaroid-centered.jpg"
$dstA.Save($outPath, $encoder, $encoderParams)

Write-Host "Saved upright polaroid to $outPath"

$gA.Dispose()
$dstA.Dispose()
$upright.Dispose()
