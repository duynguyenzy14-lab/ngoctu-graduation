# Generate softer, more graceful and gentle 35mm film ribbon
$points = @(
    @{x = 80; y = 170},
    @{x = 220; y = 220},
    @{x = 360; y = 265},
    @{x = 500; y = 280},
    @{x = 640; y = 265},
    @{x = 780; y = 240},
    @{x = 920; y = 230},
    @{x = 1060; y = 245},
    @{x = 1200; y = 280},
    @{x = 1340; y = 330},
    @{x = 1440; y = 360}
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
    $nx = -$dy / $len
    $ny = $dx / $len
    
    return @{x = $x; y = $y; nx = $nx; ny = $ny}
}

$samples = @()
$steps = 90
for ($s = 0; $s -le $steps; $s++) {
    $t = $s / $steps
    $samples += (Get-SplinePoint $points $t)
}

# Ribbon width: halfW = 23 (total width 46px - much sleeker & softer!)
$halfW = 23
$holeOffset = 16.5

$topEdge = @()
$botEdge = @()
$topHoles = @()
$botHoles = @()

foreach ($pt in $samples) {
    $topEdge += "$([math]::Round($pt.x + $pt.nx * $halfW, 1)),$([math]::Round($pt.y + $pt.ny * $halfW, 1))"
    $botEdge += "$([math]::Round($pt.x - $pt.nx * $halfW, 1)),$([math]::Round($pt.y - $pt.ny * $halfW, 1))"
    $topHoles += "$([math]::Round($pt.x + $pt.nx * $holeOffset, 1)),$([math]::Round($pt.y + $pt.ny * $holeOffset, 1))"
    $botHoles += "$([math]::Round($pt.x - $pt.nx * $holeOffset, 1)),$([math]::Round($pt.y - $pt.ny * $holeOffset, 1))"
}

$botEdgeRev = [array]::CreateInstance([string], $botEdge.Count)
[array]::Copy($botEdge, $botEdgeRev, $botEdge.Count)
[array]::Reverse($botEdgeRev)

$ribbonPoly = "M " + ($topEdge -join " L ") + " L " + ($botEdgeRev -join " L ") + " Z"
$topHolesPath = "M " + ($topHoles -join " L ")
$botHolesPath = "M " + ($botHoles -join " L ")

$svgContent = @"
<div class="connecting-film-ribbon-wrapper" aria-hidden="true">
  <svg class="connecting-film-ribbon-svg" viewBox="0 0 1440 480" fill="none" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none">
    <defs>
      <!-- Bóng đổ mềm mại dịu dàng màu hồng khói pastel -->
      <filter id="softFilmRibbonShadow" x="-10%" y="-30%" width="120%" height="160%">
        <feDropShadow dx="0" dy="8" stdDeviation="10" flood-color="rgba(180, 45, 90, 0.16)"/>
      </filter>
      <!-- Màu phim vintage nâu khói ánh hồng dịu dàng mờ nhẹ -->
      <linearGradient id="softFilmRibbonGrad" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" stop-color="#4A3440" stop-opacity="0.52"/>
        <stop offset="40%" stop-color="#583C4C" stop-opacity="0.58"/>
        <stop offset="70%" stop-color="#4E3644" stop-opacity="0.52"/>
        <stop offset="100%" stop-color="#5C3F50" stop-opacity="0.55"/>
      </linearGradient>
    </defs>

    <!-- Thân dải phim 35mm nối mềm mại dịu dàng -->
    <path d="$ribbonPoly" fill="url(#softFilmRibbonGrad)" filter="url(#softFilmRibbonShadow)" />

    <!-- Viền mép bóng thanh mảnh nhẹ nhàng -->
    <path d="M $($topEdge -join ' L ')" stroke="rgba(255, 255, 255, 0.28)" stroke-width="0.8" fill="none" />
    <path d="M $($botEdge -join ' L ')" stroke="rgba(255, 255, 255, 0.2)" stroke-width="0.8" fill="none" />

    <!-- Hàng lỗ perforation 35mm phía trên (nhỏ nhắn, bo tròn dịu dàng) -->
    <path d="$topHolesPath" stroke="#FFF8FB" stroke-opacity="0.85" stroke-width="5.5" stroke-dasharray="6.5 5.5" stroke-linecap="round" fill="none" />

    <!-- Hàng lỗ perforation 35mm phía dưới (nhỏ nhắn, bo tròn dịu dàng) -->
    <path d="$botHolesPath" stroke="#FFF8FB" stroke-opacity="0.85" stroke-width="5.5" stroke-dasharray="6.5 5.5" stroke-linecap="round" fill="none" />
  </svg>
</div>
"@

[System.IO.File]::WriteAllText("$PSScriptRoot\soft_ribbon_svg.txt", $svgContent)
Write-Host "Soft ribbon generated successfully!"
