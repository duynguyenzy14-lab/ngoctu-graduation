$insideCap = @'
                <div class="inside-cap" aria-hidden="true">
                  <svg viewBox="0 0 120 120" width="100%" height="100%" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                      <linearGradient id="icapTop" x1="15%" y1="0%" x2="85%" y2="100%">
                        <stop offset="0%" stop-color="#7B1A46"/>
                        <stop offset="45%" stop-color="#541230"/>
                        <stop offset="100%" stop-color="#2D0819"/>
                      </linearGradient>
                      <linearGradient id="icapEdge" x1="0%" y1="0%" x2="100%" y2="50%">
                        <stop offset="0%" stop-color="#3D0B22"/>
                        <stop offset="50%" stop-color="#240514"/>
                        <stop offset="100%" stop-color="#18030D"/>
                      </linearGradient>
                      <linearGradient id="icapBase" x1="0%" y1="0%" x2="0%" y2="100%">
                        <stop offset="0%" stop-color="#38091F"/>
                        <stop offset="100%" stop-color="#1F0411"/>
                      </linearGradient>
                      <linearGradient id="icapGold" x1="0%" y1="0%" x2="100%" y2="100%">
                        <stop offset="0%" stop-color="#FFF5D6"/>
                        <stop offset="35%" stop-color="#ECC870"/>
                        <stop offset="70%" stop-color="#D4AF37"/>
                        <stop offset="100%" stop-color="#9E7318"/>
                      </linearGradient>
                      <linearGradient id="icapTassel" x1="0%" y1="0%" x2="50%" y2="100%">
                        <stop offset="0%" stop-color="#FFF2D0"/>
                        <stop offset="30%" stop-color="#ECC870"/>
                        <stop offset="75%" stop-color="#D49B45"/>
                        <stop offset="100%" stop-color="#B36F1E"/>
                      </linearGradient>
                      <linearGradient id="icapRibbon" x1="0%" y1="0%" x2="100%" y2="100%">
                        <stop offset="0%" stop-color="#FFA8C5"/>
                        <stop offset="100%" stop-color="#E8275E"/>
                      </linearGradient>
                    </defs>
                    <path d="M38 52 C38 66 82 66 82 52 Z" fill="url(#icapBase)"/>
                    <path d="M38 52 C44 68 76 68 82 52" stroke="url(#icapGold)" stroke-width="1.2" opacity="0.6"/>
                    <polygon points="12,38 60,62 108,38 108,43 60,67 12,43" fill="url(#icapEdge)"/>
                    <polygon points="60,14 108,38 60,62 12,38" fill="url(#icapTop)" stroke="rgba(255, 205, 225, 0.4)" stroke-width="1"/>
                    <path d="M58 18 L104 38 L60 60" stroke="rgba(255, 255, 255, 0.22)" stroke-width="1.2" stroke-linecap="round"/>
                    <path d="M26 18 Q26 23 21 23 Q26 23 26 28 Q26 23 31 23 Q26 23 26 18 Z" fill="url(#icapGold)"/>
                    <circle cx="26" cy="23" r="1" fill="#FFFFFF"/>
                    <ellipse cx="60" cy="38" rx="5" ry="4" fill="url(#icapGold)"/>
                    <circle cx="60" cy="37.5" r="2.2" fill="#FFF9E6"/>
                    <path d="M60 38 Q78 35 94 36 Q108 38 104 52 Q98 62 100 75" stroke="url(#icapTassel)" stroke-width="2.8" stroke-linecap="round"/>
                    <path d="M60 38 Q78 35 94 36 Q108 38 104 52 Q98 62 100 75" stroke="#FFFFFF" stroke-width="0.8" opacity="0.6" stroke-linecap="round"/>
                    <ellipse cx="100" cy="76" rx="4.2" ry="2.2" fill="url(#icapGold)"/>
                    <path d="M96 74 C91 70 91 78 96 75 Z" fill="url(#icapRibbon)"/>
                    <path d="M104 74 C109 70 109 78 104 75 Z" fill="url(#icapRibbon)"/>
                    <circle cx="100" cy="74.5" r="1.5" fill="url(#icapGold)"/>
                    <path d="M96 77 C94 86 91 97 93 104 C97 106 103 106 107 104 C109 97 106 86 104 77 Z" fill="url(#icapTassel)"/>
                    <path d="M95 80 L94 103 M97 78 L97 104 M100 78 L100 105 M103 78 L103 104 M105 80 L106 103" stroke="#7A4B10" stroke-width="0.75" opacity="0.5"/>
                    <path d="M98 79 L98 104 M101 79 L101 104" stroke="#FFF5D6" stroke-width="0.6" opacity="0.7"/>
                  </svg>
                </div>
'@

$paperCap = @'
            <div class="paper-cap" aria-hidden="true">
              <svg viewBox="0 0 120 120" width="100%" height="100%" fill="none" xmlns="http://www.w3.org/2000/svg">
                <defs>
                  <linearGradient id="pcapTop" x1="15%" y1="0%" x2="85%" y2="100%">
                    <stop offset="0%" stop-color="#7B1A46"/>
                    <stop offset="45%" stop-color="#541230"/>
                    <stop offset="100%" stop-color="#2D0819"/>
                  </linearGradient>
                  <linearGradient id="pcapEdge" x1="0%" y1="0%" x2="100%" y2="50%">
                    <stop offset="0%" stop-color="#3D0B22"/>
                    <stop offset="50%" stop-color="#240514"/>
                    <stop offset="100%" stop-color="#18030D"/>
                  </linearGradient>
                  <linearGradient id="pcapBase" x1="0%" y1="0%" x2="0%" y2="100%">
                    <stop offset="0%" stop-color="#38091F"/>
                    <stop offset="100%" stop-color="#1F0411"/>
                  </linearGradient>
                  <linearGradient id="pcapGold" x1="0%" y1="0%" x2="100%" y2="100%">
                    <stop offset="0%" stop-color="#FFF5D6"/>
                    <stop offset="35%" stop-color="#ECC870"/>
                    <stop offset="70%" stop-color="#D4AF37"/>
                    <stop offset="100%" stop-color="#9E7318"/>
                  </linearGradient>
                  <linearGradient id="pcapTassel" x1="0%" y1="0%" x2="50%" y2="100%">
                    <stop offset="0%" stop-color="#FFF2D0"/>
                    <stop offset="30%" stop-color="#ECC870"/>
                    <stop offset="75%" stop-color="#D49B45"/>
                    <stop offset="100%" stop-color="#B36F1E"/>
                  </linearGradient>
                  <linearGradient id="pcapRibbon" x1="0%" y1="0%" x2="100%" y2="100%">
                    <stop offset="0%" stop-color="#FFA8C5"/>
                    <stop offset="100%" stop-color="#E8275E"/>
                  </linearGradient>
                </defs>
                <path d="M38 52 C38 66 82 66 82 52 Z" fill="url(#pcapBase)"/>
                <path d="M38 52 C44 68 76 68 82 52" stroke="url(#pcapGold)" stroke-width="1.2" opacity="0.6"/>
                <polygon points="12,38 60,62 108,38 108,43 60,67 12,43" fill="url(#pcapEdge)"/>
                <polygon points="60,14 108,38 60,62 12,38" fill="url(#pcapTop)" stroke="rgba(255, 205, 225, 0.4)" stroke-width="1"/>
                <path d="M58 18 L104 38 L60 60" stroke="rgba(255, 255, 255, 0.22)" stroke-width="1.2" stroke-linecap="round"/>
                <path d="M26 18 Q26 23 21 23 Q26 23 26 28 Q26 23 31 23 Q26 23 26 18 Z" fill="url(#pcapGold)"/>
                <circle cx="26" cy="23" r="1" fill="#FFFFFF"/>
                <ellipse cx="60" cy="38" rx="5" ry="4" fill="url(#pcapGold)"/>
                <circle cx="60" cy="37.5" r="2.2" fill="#FFF9E6"/>
                <path d="M60 38 Q78 35 94 36 Q108 38 104 52 Q98 62 100 75" stroke="url(#pcapTassel)" stroke-width="2.8" stroke-linecap="round"/>
                <path d="M60 38 Q78 35 94 36 Q108 38 104 52 Q98 62 100 75" stroke="#FFFFFF" stroke-width="0.8" opacity="0.6" stroke-linecap="round"/>
                <ellipse cx="100" cy="76" rx="4.2" ry="2.2" fill="url(#pcapGold)"/>
                <path d="M96 74 C91 70 91 78 96 75 Z" fill="url(#pcapRibbon)"/>
                <path d="M104 74 C109 70 109 78 104 75 Z" fill="url(#pcapRibbon)"/>
                <circle cx="100" cy="74.5" r="1.5" fill="url(#pcapGold)"/>
                <path d="M96 77 C94 86 91 97 93 104 C97 106 103 106 107 104 C109 97 106 86 104 77 Z" fill="url(#pcapTassel)"/>
                <path d="M95 80 L94 103 M97 78 L97 104 M100 78 L100 105 M103 78 L103 104 M105 80 L106 103" stroke="#7A4B10" stroke-width="0.75" opacity="0.5"/>
                <path d="M98 79 L98 104 M101 79 L101 104" stroke="#FFF5D6" stroke-width="0.6" opacity="0.7"/>
              </svg>
            </div>
'@

$content = [System.IO.File]::ReadAllText("index.html", [System.Text.Encoding]::UTF8)

# Insert inside-cap
$targetInside = '<span class="diploma-border"></span>'
if ($content.Contains($targetInside)) {
    $content = $content.Replace($targetInside, "$targetInside`r`n$insideCap")
    Write-Host "Inserted insideCap into index.html"
} else {
    Write-Error "Could not find targetInside"
}

# Insert paper-cap
$targetPaper = '<article class="paper" id="paper">'
if ($content.Contains($targetPaper)) {
    $content = $content.Replace($targetPaper, "$targetPaper`r`n$paperCap")
    Write-Host "Inserted paperCap into index.html"
} else {
    Write-Error "Could not find targetPaper"
}

[System.IO.File]::WriteAllText("index.html", $content, [System.Text.Encoding]::UTF8)
Write-Host "Done!"
