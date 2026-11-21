Add-Type -AssemblyName System.Drawing

function Inspect-Img($name, $path) {
    if (Test-Path $path) {
        $img = [System.Drawing.Image]::FromFile($path)
        Write-Host "$name : $($img.Width) x $($img.Height)"
        $img.Dispose()
    }
}

Inspect-Img "tu.JPG" "$PSScriptRoot\..\tu.JPG"
Inspect-Img "tu-800.jpg" "$PSScriptRoot\..\tu-800.jpg"
Inspect-Img "LVHQ0663.JPG" "$PSScriptRoot\..\LVHQ0663.JPG"
Inspect-Img "lvhq0663-portrait.jpg" "$PSScriptRoot\..\graduation_files\lvhq0663-portrait.jpg"
