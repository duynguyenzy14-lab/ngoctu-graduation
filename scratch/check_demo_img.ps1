Add-Type -AssemblyName System.Drawing
$img = [System.Drawing.Bitmap]::FromFile("C:\Users\Tu Nguyen\.gemini\antigravity\brain\b7930d6f-f794-44be-a7c4-f47bb58aece3\.user_uploaded\media_1795188080841_18937cc6.png")
Write-Host "Demo img: $($img.Width) x $($img.Height)"
$img.Dispose()
