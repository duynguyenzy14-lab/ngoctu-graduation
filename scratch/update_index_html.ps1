$htmlPath = "$PSScriptRoot\..\index.html"
$content = [System.IO.File]::ReadAllText($htmlPath, [System.Text.Encoding]::UTF8)

# 1. Update Google Fonts link to ensure full Playfair Display weights and styles
$oldFont = '<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@600;700&family=Dancing+Script:wght@600;700&family=Nunito:ital,wght@0,400;0,500;0,600;0,700;0,800;1,400&family=Playfair+Display:ital,wght@0,400;0,500;0,600;0,700;0,800;1,400;1,600&display=swap" rel="stylesheet">'
$newFont = '<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,500;0,600;0,700;0,800;0,900;1,400;1,500;1,600;1,700;1,800&family=Caveat:wght@600;700&family=Dancing+Script:wght@600;700&display=swap" rel="stylesheet">'

if ($content.Contains($oldFont)) {
    $content = $content.Replace($oldFont, $newFont)
    Write-Host "Replaced Google Fonts link."
} else {
    Write-Host "Google fonts link pattern not exact match, checking alternate."
}

# 2. Update Ribbon SVG
$ribbonSvg = [System.IO.File]::ReadAllText("$PSScriptRoot\gentle_ribbon_svg.txt", [System.Text.Encoding]::UTF8).Trim()

$startMarker = '<!-- THƯỚC PHIM NỐI 2 SECTION THEO MẪU DEMO (MỀM MẠI DỊU DÀNG) -->'
$endMarker = '<!-- ================= SECTION 01: NẰM BÊN TRÁI'

$p1 = $content.IndexOf($startMarker)
$p2 = $content.IndexOf($endMarker)

if ($p1 -ge 0 -and $p2 -gt $p1) {
    $before = $content.Substring(0, $p1)
    $after = $content.Substring($p2)
    $content = $before + $ribbonSvg + "`r`n`r`n        " + $after
    Write-Host "Replaced Ribbon SVG successfully."
} else {
    Write-Host "Ribbon markers not found: p1=$p1, p2=$p2"
}

# 3. Top bar meta tags:
# Kodak -> Quản lý công, 35mm -> Graduatio
$oldTopMeta = @"
                  <div class="film-meta-text">
                    <span class="meta-tag">▶ KODAK PORTRA 400</span>
                    <span class="meta-tag">35mm SAFETY FILM</span>
                    <span class="meta-tag">OU · 2022–2026</span>
                  </div>
"@

$newTopMeta = @"
                  <div class="film-meta-text">
                    <span class="meta-tag">▶ QUẢN LÝ CÔNG</span>
                    <span class="meta-tag">GRADUATIO</span>
                    <span class="meta-tag">OU · 2022–2026</span>
                  </div>
"@

$content = $content.Replace($oldTopMeta.Replace("`r`n", "`n"), $newTopMeta.Replace("`r`n", "`n"))
$content = $content.Replace($oldTopMeta, $newTopMeta)

# 4. Bottom bar meta tags:
# Safety -> Quản lý công, delete exposure2.0
$oldBotMeta = @"
                  <div class="film-meta-text">
                    <span class="meta-tag">SAFETY FILM</span>
                    <span class="meta-tag">EXPOSURE 20</span>
                    <span class="meta-tag">NGUYỄN NGỌC TÚ · OU GRADUATION</span>
                  </div>
"@

$newBotMeta = @"
                  <div class="film-meta-text">
                    <span class="meta-tag">QUẢN LÝ CÔNG</span>
                    <span class="meta-tag">NGUYỄN NGỌC TÚ · OU GRADUATION</span>
                  </div>
"@

$content = $content.Replace($oldBotMeta.Replace("`r`n", "`n"), $newBotMeta.Replace("`r`n", "`n"))
$content = $content.Replace($oldBotMeta, $newBotMeta)

[System.IO.File]::WriteAllText($htmlPath, $content, [System.Text.Encoding]::UTF8)
Write-Host "Updated index.html successfully!"
