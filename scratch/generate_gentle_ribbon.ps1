# Catmull-Rom Spline generator for ultra-graceful, soft 35mm film ribbon
$controlPts = @(
    [PSCustomObject]@{ x = -50.0; y = 140.0 },
    [PSCustomObject]@{ x = 160.0; y = 230.0 },
    [PSCustomObject]@{ x = 360.0; y = 295.0 },
    [PSCustomObject]@{ x = 540.0; y = 245.0 },
    [PSCustomObject]@{ x = 720.0; y = 185.0 },
    [PSCustomObject]@{ x = 900.0; y = 180.0 },
    [PSCustomObject]@{ x = 1080.0; y = 265.0 },
    [PSCustomObject]@{ x = 1260.0; y = 320.0 },
    [PSCustomObject]@{ x = 1490.0; y = 230.0 }
)

function Get-SplinePoint($pts, $t) {
    $n = $pts.Count - 1
    $pos = $t * $n
    $i = [math]::Floor($pos)
    if ($i -ge $n) { $i = $n - 1 }
    $localT = $pos - $i
    
    $p0 = if ($i -gt 0) { $pts[$i - 1] } else { $pts[0] }
    $p1 = $pts[$i]
    $p2 = $pts[$i + 1]
    $p3 = if ($i + 2 -le $n) { $pts[$i + 2] } else { $pts[$n] }
    
    $t2 = $localT * $localT
    $t3 = $t2 * $localT
    
    $x = 0.5 * ((2 * $p1.x) + (-$p0.x + $p2.x) * $localT + (2 * $p0.x - 5 * $p1.x + 4 * $p2.x - $p3.x) * $t2 + (-$p0.x + 3 * $p1.x - 3 * $p2.x + $p3.x) * $t3)
    $y = 0.5 * ((2 * $p1.y) + (-$p0.y + $p2.y) * $localT + (2 * $p0.y - 5 * $p1.y + 4 * $p2.y - $p3.y) * $t2 + (-$p0.y + 3 * $p1.y - 3 * $p2.y + $p3.y) * $t3)
    
    $dx = 0.5 * ((-$p0.x + $p2.x) + 2 * (2 * $p0.x - 5 * $p1.x + 4 * $p2.x - $p3.x) * $localT + 3 * (-$p0.x + 3 * $p1.x - 3 * $p2.x + $p3.x) * $t2)
    $dy = 0.5 * ((-$p0.y + $p2.y) + 2 * (2 * $p0.y - 5 * $p1.y + 4 * $p2.y - $p3.y) * $localT + 3 * (-$p0.y + 3 * $p1.y - 3 * $p2.y + $p3.y) * $t2)
    
    $len = [math]::Sqrt($dx * $dx + $dy * $dy)
    if ($len -eq 0) { $len = 1 }
    $nx = -$dy / $len
    $ny = $dx / $len
    
    return [PSCustomObject]@{ x = $x; y = $y; nx = $nx; ny = $ny }
}

$steps = 100
$samples = @()
for ($s = 0; $s -le $steps; $s++) {
    $t = $s / $steps
    $samples += (Get-SplinePoint $controlPts $t)
}

# Slender, gentle ribbon width: 38px total (halfW = 19px)
$halfW = 19.0
$holeOffset = 13.5

$topEdge = @()
$botEdge = @()
$topHoles = @()
$botHoles = @()

foreach ($pt in $samples) {
    $topEdge += ("{0:F1},{1:F1}" -f ($pt.x + $pt.nx * $halfW), ($pt.y + $pt.ny * $halfW))
    $botEdge += ("{0:F1},{1:F1}" -f ($pt.x - $pt.nx * $halfW), ($pt.y - $pt.ny * $halfW))
    $topHoles += ("{0:F1},{1:F1}" -f ($pt.x + $pt.nx * $holeOffset), ($pt.y + $pt.ny * $holeOffset))
    $botHoles += ("{0:F1},{1:F1}" -f ($pt.x - $pt.nx * $holeOffset), ($pt.y - $pt.ny * $holeOffset))
}

$botEdgeRev = [array]::CreateInstance([string], $botEdge.Count)
[array]::Copy($botEdge, $botEdgeRev, $botEdge.Count)
[array]::Reverse($botEdgeRev)

$ribbonPoly = "M " + ($topEdge -join " L ") + " L " + ($botEdgeRev -join " L ") + " Z"
$topHolesPath = "M " + ($topHoles -join " L ")
$botHolesPath = "M " + ($botHoles -join " L ")

$svgContent = @"
        <!-- THƯỚC PHIM NỐI 2 SECTION THEO MẪU DEMO (MỀM MẠI DỊU DÀNG) -->
        <div class="connecting-film-ribbon-wrapper" aria-hidden="true">
          <svg class="connecting-film-ribbon-svg" viewBox="0 0 1440 480" fill="none" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none">
            <defs>
              <!-- Bóng đổ mềm mại dịu dàng màu hồng khói pastel -->
              <filter id="softFilmRibbonShadow" x="-10%" y="-30%" width="120%" height="160%">
                <feDropShadow dx="0" dy="6" stdDeviation="8" flood-color="rgba(195, 75, 120, 0.14)"/>
              </filter>
              <!-- Màu phim vintage nâu khói ánh hồng dịu dàng mờ nhẹ -->
              <linearGradient id="softFilmRibbonGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stop-color="#553A47" stop-opacity="0.38"/>
                <stop offset="35%" stop-color="#6E4458" stop-opacity="0.44"/>
                <stop offset="65%" stop-color="#5A3A4C" stop-opacity="0.42"/>
                <stop offset="100%" stop-color="#6A4255" stop-opacity="0.40"/>
              </linearGradient>
            </defs>

            <!-- Thân dải phim 35mm nối mềm mại dịu dàng -->
            <path d="$ribbonPoly" fill="url(#softFilmRibbonGrad)" filter="url(#softFilmRibbonShadow)" />

            <!-- Viền mép bóng thanh mảnh nhẹ nhàng -->
            <path d="M $($topEdge -join ' L ')" stroke="rgba(255, 255, 255, 0.28)" stroke-width="0.75" fill="none" />
            <path d="M $($botEdge -join ' L ')" stroke="rgba(255, 255, 255, 0.22)" stroke-width="0.75" fill="none" />

            <!-- Hàng lỗ perforation 35mm phía trên (nhỏ nhắn, bo tròn dịu dàng) -->
            <path d="$topHolesPath" stroke="#FFF7FB" stroke-opacity="0.8" stroke-width="4.2" stroke-dasharray="5.5 5" stroke-linecap="round" fill="none" />

            <!-- Hàng lỗ perforation 35mm phía dưới (nhỏ nhắn, bo tròn dịu dàng) -->
            <path d="$botHolesPath" stroke="#FFF7FB" stroke-opacity="0.8" stroke-width="4.2" stroke-dasharray="5.5 5" stroke-linecap="round" fill="none" />
          </svg>
        </div>
"@

[System.IO.File]::WriteAllText("$PSScriptRoot\gentle_ribbon_svg.txt", $svgContent, [System.Text.Encoding]::UTF8)
Write-Host "Generated gentle ribbon SVG with $($samples.Count) steps successfully!"
