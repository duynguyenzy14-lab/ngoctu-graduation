# apply_v10.ps1
$ErrorActionPreference = "Stop"

# -------------------------------------------------------------
# 1. Update index.html
# -------------------------------------------------------------
$html = Get-Content -Path "index.html" -Raw -Encoding UTF8

# 1.1 Bỏ chữ "nhé" trong thư mời
$html = $html -replace 'khoảnh khắc đáng nhớ nhé ♡', 'khoảnh khắc đáng nhớ ♡'

# 1.2 Bỏ cái hộp "RSVP"
$targetRsvpBadge = @"
            <div class="rsvp-badge">
              <span>💌 RSVP</span>
            </div>
"@
$html = $html.Replace($targetRsvpBadge, "")

# 1.3 Bỏ icon ngay "sẽ đến nha" và "tiếc quá"
$targetRadioRow = @"
                <div class="radio-options-row">
                  <label class="radio-card is-selected">
                    <input type="radio" name="attending" value="yes" checked>
                    <span class="radio-card-content">
                      <span class="radio-emoji">💖</span>
                      <span class="radio-text">Sẽ đến nhaa!</span>
                    </span>
                  </label>
                  <label class="radio-card">
                    <input type="radio" name="attending" value="no">
                    <span class="radio-card-content">
                      <span class="radio-emoji">🥺</span>
                      <span class="radio-text">Tiếc quá, bận rồi</span>
                    </span>
                  </label>
                </div>
"@

$replaceRadioRow = @"
                <div class="radio-options-row">
                  <label class="radio-card is-selected">
                    <input type="radio" name="attending" value="yes" checked>
                    <span class="radio-card-content">
                      <span class="radio-text">Sẽ đến nhaa!</span>
                    </span>
                  </label>
                  <label class="radio-card">
                    <input type="radio" name="attending" value="no">
                    <span class="radio-card-content">
                      <span class="radio-text">Tiếc quá, bận rồi</span>
                    </span>
                  </label>
                </div>
"@
$html = $html.Replace($targetRadioRow, $replaceRadioRow)

# 1.4 Làm sạch og:image query parameter
$html = $html -replace '\./graduation_files/tu-polaroid-centered\.jpg\?v=rot90', './graduation_files/tu-polaroid-centered.jpg'

[System.IO.File]::WriteAllText("$PSScriptRoot\..\index.html", $html, [System.Text.Encoding]::UTF8)
Write-Host "Updated index.html successfully for v10!"

# -------------------------------------------------------------
# 2. Update script.js
# -------------------------------------------------------------
$js = Get-Content -Path "script.js" -Raw -Encoding UTF8

# 2.1 Bỏ chữ "nhé" trong các bức thư cá nhân hóa
$js = $js -replace 'khoảnh khắc đáng nhớ nhé ♡', 'khoảnh khắc đáng nhớ ♡'

# 2.2 Bỏ emoji trong attendingText
$js = $js -replace 'const attendingText = attendingVal === "yes" \? "Sẽ đến nhaa! 💖" : "Tiếc quá, bận rồi 🥺";', 'const attendingText = attendingVal === "yes" ? "Sẽ đến nhaa!" : "Tiếc quá, bận rồi";'
$js = $js -replace 'escapeHtml\(item\.attending \|\| "Sẽ đến nhaa! 💖"\)', 'escapeHtml(item.attending || "Sẽ đến nhaa!")'

[System.IO.File]::WriteAllText("$PSScriptRoot\..\script.js", $js, [System.Text.Encoding]::UTF8)
Write-Host "Updated script.js successfully for v10!"
