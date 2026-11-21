Add-Type -AssemblyName System.Drawing

function Inspect($file) {
    if (-not (Test-Path $file)) { return }
    $img = [System.Drawing.Image]::FromFile((Resolve-Path $file))
    Write-Host "$file : $($img.Width) x $($img.Height)"
    $img.Dispose()
}

Inspect ".\tu.JPG"
Inspect ".\tu-800.jpg"
Inspect ".\graduation_files\guest-ngoctu-800.webp"
Inspect ".\graduation_files\lvhq0663-800.jpg"
Inspect ".\graduation_files\lvhq0663-portrait.jpg"
