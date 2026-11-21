Add-Type -AssemblyName System.Drawing

function Check-Bounds($path) {
    $bmp = [System.Drawing.Bitmap]::FromFile($path)
    Write-Host "$path -> Width: $($bmp.Width), Height: $($bmp.Height)"
    $bmp.Dispose()
}

Check-Bounds "$PSScriptRoot\..\graduation_files\lvhq0663-portrait.jpg"
Check-Bounds "$PSScriptRoot\..\tu.JPG"
Check-Bounds "$PSScriptRoot\..\tu-800.jpg"
Check-Bounds "$PSScriptRoot\..\LVHQ0663.JPG"
