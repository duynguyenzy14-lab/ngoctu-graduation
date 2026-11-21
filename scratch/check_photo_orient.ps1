Add-Type -AssemblyName System.Drawing

function Check-Img($path) {
    if (-not (Test-Path $path)) { return }
    $img = [System.Drawing.Image]::FromFile((Resolve-Path $path))
    $orient = "None"
    foreach ($p in $img.PropertyItems) {
        if ($p.Id -eq 0x0112) {
            $orient = $p.Value[0].ToString()
        }
    }
    Write-Host "$path : $($img.Width) x $($img.Height), EXIF Orientation = $orient"
    $img.Dispose()
}

Check-Img ".\LVHQ0663.JPG"
Check-Img ".\tu.JPG"
Check-Img ".\tu-800.jpg"
Check-Img ".\graduation_files\tu-polaroid-centered.jpg"
Check-Img ".\graduation_files\lvhq0663-portrait.jpg"
Check-Img ".\graduation_files\lvhq0663-800.jpg"
