Add-Type -AssemblyName System.Drawing
$files = @(
    "$PSScriptRoot\..\LVHQ0663.JPG",
    "$PSScriptRoot\..\tu.JPG",
    "$PSScriptRoot\..\tu-800.jpg",
    "$PSScriptRoot\..\graduation_files\lvhq0663-portrait.jpg"
)
foreach ($f in $files) {
    if (Test-Path $f) {
        $img = [System.Drawing.Image]::FromFile($f)
        Write-Host "$f => $($img.Width) x $($img.Height)"
        $img.Dispose()
    } else {
        Write-Host "$f NOT found"
    }
}
