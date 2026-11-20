# Generate smooth curved 35mm film ribbon with sprocket holes
$points = @(
    @{x = 100; y = 140},
    @{x = 220; y = 205},
    @{x = 340; y = 265},
    @{x = 460; y = 290},
    @{x = 580; y = 280},
    @{x = 700; y = 250},
    @{x = 840; y = 230},
    @{x = 980; y = 235},
    @{x = 1120; y = 270},
    @{x = 1260; y = 330},
    @{x = 1380; y = 375}
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
$steps = 80
for ($s = 0; $s -le $steps; $s++) {
    $t = $s / $steps
    $samples += (Get-SplinePoint $points $t)
}

$halfW = 34
$holeOffset = 24

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
  <svg class="connecting-film-ribbon-svg" viewBox="0 0 1440 500" fill="none" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none">
    <defs>
      <filter id="filmRibbonShadow" x="-10%" y="-20%" width="120%" height="150%">
        <feDropShadow dx="0" dy="10" stdDeviation="12" flood-color="rgba(35, 15, 25, 0.28)"/>
      </filter>
      <linearGradient id="filmRibbonGrad" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" stop-color="#2D2228" stop-opacity="0.82"/>
        <stop offset="35%" stop-color="#3A2C34" stop-opacity="0.88"/>
        <stop offset="70%" stop-color="#2D2228" stop-opacity="0.82"/>
        <stop offset="100%" stop-color="#3E2E37" stop-opacity="0.85"/>
      </linearGradient>
    </defs>

    <!-- Thân dải phim 35mm nối 2 section uốn lượn vintage -->
    <path d="$ribbonPoly" fill="url(#filmRibbonGrad)" filter="url(#filmRibbonShadow)" />

    <!-- Viền mép bóng thanh mảnh của dải phim -->
    <path d="M $($topEdge -join ' L ')" stroke="rgba(255, 255, 255, 0.15)" stroke-width="1.2" fill="none" />
    <path d="M $($botEdge -join ' L ')" stroke="rgba(255, 255, 255, 0.1)" stroke-width="1.2" fill="none" />

    <!-- Hàng lỗ perforation 35mm phía trên (Dashed) -->
    <path d="$topHolesPath" stroke="#FFF7FA" stroke-opacity="0.9" stroke-width="8" stroke-dasharray="9 7" stroke-linecap="butt" fill="none" />

    <!-- Hàng lỗ perforation 35mm phía dưới (Dashed) -->
    <path d="$botHolesPath" stroke="#FFF7FA" stroke-opacity="0.9" stroke-width="8" stroke-dasharray="9 7" stroke-linecap="butt" fill="none" />
  </svg>
</div>
"@

[System.IO.File]::WriteAllText("$PSScriptRoot\ribbon_svg.txt", $svgContent)
Write-Host "SVG generated successfully without errors!"
