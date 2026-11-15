$utf8 = [System.Text.UTF8Encoding]::new($false)
$cssFile = "graduation_files\style.css"
$css = [System.IO.File]::ReadAllText($cssFile, [System.Text.Encoding]::UTF8)

# Normalize line endings to LF
$css = $css.Replace("`r`n", "`n")

# 1. Remove the trailing duplicate block at the end (from "/* Sảnh lời chúc:" to end of file)
$dupIdx = $css.IndexOf("/* Sảnh lời chúc:")
if ($dupIdx -gt 0) {
    $css = $css.Substring(0, $dupIdx).TrimEnd() + "`n"
    Write-Output "Removed duplicate trailing gb block."
}

# 2. Replace lines from "/* bảng lời chúc */" up to before "footer {"
$startB = $css.IndexOf("/* bảng lời chúc */")
$endB = $css.IndexOf("footer {", $startB)

$unifiedGb = @'
/* Sảnh lời chúc: kích thước và thiết kế cân bằng hoàn hảo với thiệp bên trái */
.gb {
  width: 100%;
  height: 100%;
  box-sizing: border-box;
  background-color: #FFFDFC;
  color: var(--ink);
  border-radius: clamp(20px, 2.8vw, 28px) !important;
  padding: clamp(20px, 2.4vw, 30px);
  box-shadow: 0 30px 60px -30px rgba(120, 20, 60, .22), inset 0 0 0 1px rgba(255, 182, 193, 0.4) !important;
  border: 1.5px solid #F8D3E2;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  min-width: 0;
}
.gb h3 {
  margin: 0 0 8px 0;
  font-family: var(--font);
  font-weight: 700;
  font-size: clamp(18px, 2vw, 23px);
  color: var(--volt);
  letter-spacing: -0.015em;
}
.gb-ticker {
  margin: 0 0 10px;
  overflow: hidden;
  -webkit-mask-image: linear-gradient(90deg, transparent, #000 8%, #000 92%, transparent);
  mask-image: linear-gradient(90deg, transparent, #000 8%, #000 92%, transparent);
}
.gb-tt {
  display: flex;
  width: max-content;
  white-space: nowrap;
  font: 500 13px/1.5 var(--font);
  color: var(--slate);
  animation: ticker var(--dur, 40s) linear infinite;
}
.gb-tt span { padding-right: 40px; }
.gb-tt b { font-weight: 600; color: var(--volt); margin-right: 5px; }
@keyframes ticker { to { transform: translateX(-50%); } }

.gb-card {
  position: relative;
  overflow: hidden;
  border: 1.5px dashed #F8CADB;
  border-radius: 16px;
  padding: clamp(14px, 2vw, 22px);
  flex: 1;
  min-height: 170px;
  display: grid;
  grid-template-rows: 1fr auto;
  gap: 14px;
  background: #FFF5F8;
}
.gb-card.fly .gb-who { animation: flyIn .7s var(--ease) both; }
.gb-card.fly .gb-quote { animation: flyIn .8s var(--ease) both; }
@keyframes flyIn { from { opacity: 0; transform: translate3d(36px, 14px, 0) rotate(1.5deg); filter: blur(6px); } to { opacity: 1; transform: none; filter: none; } }

.gb-quote {
  margin: 0;
  font: 600 clamp(16px, 1.9vw, 22px)/1.4 var(--serif);
  letter-spacing: .01em;
  color: var(--ink);
  overflow-wrap: anywhere;
}
.caret { display: inline-block; width: .08em; min-width: 2px; height: 1em; margin-left: 3px; vertical-align: -.12em; background: currentColor; animation: blink 1s steps(1) infinite; }
@keyframes blink { 50% { opacity: 0; } }

.gb-who { display: flex; align-items: center; gap: 10px; }
.gb-av {
  width: 38px;
  height: 38px;
  border-radius: 50%;
  display: grid;
  place-items: center;
  background: linear-gradient(135deg, #FF69B4, #E0266B);
  color: #fff;
  font-weight: 600;
  box-shadow: 0 3px 10px rgba(255, 64, 129, .35);
}
.gb-who b { display: block; font: 700 13.5px var(--font); color: var(--ink); }
.gb-who small { display: block; font: 500 11.5px var(--font); color: var(--slate); }
.gb-bar { position: absolute; left: 0; right: 0; bottom: 0; height: 2px; background: var(--volt); opacity: .65; transform: scaleX(0); transform-origin: 0 50%; }

.gb-nav {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 14px;
  margin-top: 10px;
  font: 600 13px var(--font);
}
.gb-nav button { background: none; border: 0; color: var(--slate); font: inherit; cursor: pointer; padding: 4px; }
.gb-nav button:hover { color: var(--volt); }
.gb-nav span { font-variant-numeric: tabular-nums; color: var(--slate); }
.gb-nav span b { color: var(--ink); font-weight: 500; }

'@.Replace("`r`n", "`n")

if ($startB -ge 0 -and $endB -gt $startB) {
    $css = $css.Substring(0, $startB) + $unifiedGb + $css.Substring($endB)
    Write-Output "Unified gb block applied."
} else {
    Write-Output "ERROR: gb block markers not found."
}

[System.IO.File]::WriteAllText($cssFile, $css.Replace("`n", "`r`n"), $utf8)
Write-Output "style.css updated successfully."
