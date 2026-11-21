$html = [System.IO.File]::ReadAllText("$PSScriptRoot\..\index.html")
$css = [System.IO.File]::ReadAllText("$PSScriptRoot\..\style.css")
$js = [System.IO.File]::ReadAllText("$PSScriptRoot\..\script.js")

Write-Host "Title removed from HTML: $(!($html -match 'BỐN NĂM, THẬT NHIỀU KHOẢNH KHẮC'))"
Write-Host "Sound/audio removed from HTML: $(!($html -match 'btnSoundControl|bgAudio|ytMusicPlayer'))"
Write-Host "Sound/audio removed from JS: $(!($js -match 'ytPlayer|bgAudio|initSoundControls'))"
Write-Host "Sound removed from CSS: $(!($css -match 'btn-sound-control'))"

$cssOpen = ([regex]::Matches($css, '\{')).Count
$cssClose = ([regex]::Matches($css, '\}')).Count
Write-Host "CSS braces match: $($cssOpen -eq $cssClose) ($cssOpen vs $cssClose)"

$jsOpen = ([regex]::Matches($js, '\{')).Count
$jsClose = ([regex]::Matches($js, '\}')).Count
Write-Host "JS braces match: $($jsOpen -eq $jsClose) ($jsOpen vs $jsClose)"
