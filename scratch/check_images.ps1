Add-Type -AssemblyName System.Drawing
$dir = "graduation_files\bg-pics"
Get-ChildItem "$dir\*.jpg" | ForEach-Object {
    $img = [System.Drawing.Image]::FromFile($_.FullName)
    [PSCustomObject]@{
        Name = $_.Name
        Width = $img.Width
        Height = $img.Height
        Ratio = [math]::Round($img.Width / $img.Height, 2)
        Orientation = if ($img.Width -gt $img.Height * 1.15) { "landscape" } elseif ($img.Height -gt $img.Width * 1.15) { "portrait" } else { "square" }
    }
    $img.Dispose()
} | Format-Table -AutoSize
