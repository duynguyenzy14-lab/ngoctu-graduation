# scratch/inspect_polaroid_img.ps1
Add-Type -AssemblyName System.Drawing
$files = Get-ChildItem "graduation_files" -Filter "*tu*"
foreach ($f in $files) {
  $img = [System.Drawing.Image]::FromFile($f.FullName)
  Write-Host "$($f.Name): Width=$($img.Width), Height=$($img.Height), AspectRatio=$( [math]::Round($img.Width / $img.Height, 3) )"
  $img.Dispose()
}

$origPhoto = "graduation_files/photos/lvhq0556-800.jpg"
if (Test-Path $origPhoto) {
  $img2 = [System.Drawing.Image]::FromFile((Resolve-Path $origPhoto))
  Write-Host "lvhq0556-800.jpg: Width=$($img2.Width), Height=$($img2.Height), AspectRatio=$( [math]::Round($img2.Width / $img2.Height, 3) )"
  $img2.Dispose()
}
