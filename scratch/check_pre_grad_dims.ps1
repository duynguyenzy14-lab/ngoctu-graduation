Add-Type -AssemblyName System.Drawing
Get-ChildItem -Path ".\graduation_files\photos\*.jpg" | ForEach-Object {
    $img = [System.Drawing.Image]::FromFile($_.FullName)
    $orient = "None"
    foreach ($p in $img.PropertyItems) {
        if ($p.Id -eq 0x0112) { $orient = $p.Value[0].ToString() }
    }
    $isPort = ($img.Height -gt $img.Width) -or ($orient -eq "6") -or ($orient -eq "8")
    Write-Host "$($_.Name) : $($img.Width) x $($img.Height) EXIF=$orient isPortrait=$isPort"
    $img.Dispose()
}
