$html = [System.IO.File]::ReadAllText("$PSScriptRoot\..\index.html")
$css = [System.IO.File]::ReadAllText("$PSScriptRoot\..\style.css")
$js = [System.IO.File]::ReadAllText("$PSScriptRoot\..\script.js")

Write-Host "--- VALIDATION CHECK ---"

# 1. Check Music / Vinyl
$hasVinylHtml = $html -match "vinyl|musicWidget"
$hasVinylCss = $css -match "vinyl-record"
Write-Host "Vinyl removed from HTML: $(!$hasVinylHtml)"
Write-Host "Vinyl removed from CSS: $(!$hasVinylCss)"

# 2. Check Nav dots
$hasNavHtml = $html -match "nav-dots|nav-dot|book-nav-indicator"
$hasNavCss = $css -match "\.nav-dots"
Write-Host "Nav dots removed from HTML: $(!$hasNavHtml)"
Write-Host "Nav dots removed from CSS: $(!$hasNavCss)"

# 3. Check Nameplate position before Polaroid
$idxNameplate = $html.IndexOf('class="personal-nameplate"')
$idxPolaroid = $html.IndexOf('class="polaroid-wrapper"')
Write-Host "Nameplate ($idxNameplate) before Polaroid ($idxPolaroid): $($idxNameplate -lt $idxPolaroid)"

# 4. Check centered photo
$hasCenteredPhoto = $html -match "tu-polaroid-centered\.jpg"
$photoExists = Test-Path "$PSScriptRoot\..\graduation_files\tu-polaroid-centered.jpg"
Write-Host "Polaroid src points to tu-polaroid-centered.jpg: $hasCenteredPhoto"
Write-Host "File tu-polaroid-centered.jpg exists: $photoExists"

# 5. Check 35mm film text
$hasQuanLyCong = $html -match "QUẢN LÝ CÔNG"
$hasGraduation = $html -match "GRADUATION"
$hasExposure = $html -match "exposure2\.0|EXPOSURE 20"
Write-Host "Film has QUẢN LÝ CÔNG: $hasQuanLyCong"
Write-Host "Film has GRADUATION: $hasGraduation"
Write-Host "Film has removed exposure: $(!$hasExposure)"

# 6. Check Sound control button
$hasSoundBtnHtml = $html -match 'id="btnSoundControl"'
$hasSoundBtnCss = $css -match '\.btn-sound-control'
$hasSoundBtnJs = $js -match 'btnSoundControl'
Write-Host "Sound button in HTML: $hasSoundBtnHtml"
Write-Host "Sound button in CSS: $hasSoundBtnCss"
Write-Host "Sound button in JS: $hasSoundBtnJs"

# 7. Check curly braces balance in CSS and JS
$cssOpen = ([regex]::Matches($css, '\{')).Count
$cssClose = ([regex]::Matches($css, '\}')).Count
Write-Host "CSS braces match: $($cssOpen -eq $cssClose) ($cssOpen vs $cssClose)"

$jsOpen = ([regex]::Matches($js, '\{')).Count
$jsClose = ([regex]::Matches($js, '\}')).Count
Write-Host "JS braces match: $($jsOpen -eq $jsClose) ($jsOpen vs $jsClose)"

Write-Host "All checks passed!"
