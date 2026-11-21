Add-Type -AssemblyName System.Drawing

function Describe-Image($path) {
    $img = [System.Drawing.Image]::FromFile($path)
    Write-Host "$path -> Width: $($img.Width), Height: $($img.Height), RawFormat: $($img.RawFormat)"
    $img.Dispose()
}

Describe-Image "$PSScriptRoot\..\tu.JPG"
Describe-Image "$PSScriptRoot\..\tu-800.jpg"
Describe-Image "$PSScriptRoot\..\LVHQ0663.JPG"
