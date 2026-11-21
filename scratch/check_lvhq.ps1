Add-Type -AssemblyName System.Drawing
$b = [System.Drawing.Bitmap]::FromFile((Resolve-Path ".\LVHQ0663.JPG"))
Write-Host "LVHQ0663.JPG orig: $($b.Width) x $($b.Height)"
$b.Dispose()
