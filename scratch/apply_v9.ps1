# apply_v9.ps1
$ErrorActionPreference = "Stop"

$css = Get-Content -Path "style.css" -Raw -Encoding UTF8

# 1. Update Polaroid to square corners & elegant chin
$oldPolaroidSectionRegex = '(?s)\.polaroid-inner\s*\{[\s\S]*?\.polaroid-caption-text\s*\{[\s\S]*?\}'
$newPolaroidSection = @"
.polaroid-inner {
  background: #FFFFFF;
  border-radius: 0;
  padding: 10px 10px 14px;
  box-shadow: 0 8px 24px rgba(180, 45, 90, 0.12), 0 2px 6px rgba(0, 0, 0, 0.06);
  border: 1px solid rgba(220, 190, 205, 0.5);
  display: flex;
  flex-direction: column;
  align-items: center;
}

.photo-container {
  width: 100%;
  aspect-ratio: 2/3;
  overflow: hidden;
  border-radius: 0;
  background: #FFF5F8;
  position: relative;
}

.polaroid-photo {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: center center;
  display: block;
}

.polaroid-caption {
  width: 100%;
  padding-top: 10px;
  padding-bottom: 2px;
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
}

.polaroid-caption-text {
  font-family: var(--font-editorial);
  font-style: italic;
  font-size: clamp(12px, 3.2vw, 13.5px);
  font-weight: 400;
  color: #7A626C;
  letter-spacing: 0.03em;
  line-height: 1.35;
  white-space: nowrap;
}
"@

$css = [System.Text.RegularExpressions.Regex]::Replace($css, $oldPolaroidSectionRegex, $newPolaroidSection)

# 2. Update btn-flip-page font-weight to 500 (ko in đậm)
$targetBtnFlip = @"
.btn-flip-page {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  background: #FFFFFF;
  color: var(--pink-accent);
  border: 1.5px solid var(--pink-border);
  border-radius: 999px;
  padding: 9px 18px;
  font-family: var(--font-editorial);
  font-size: clamp(13px, 3.4vw, 14.5px);
  font-weight: 700;
"@

$replaceBtnFlip = @"
.btn-flip-page {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  background: #FFFFFF;
  color: var(--pink-accent);
  border: 1.5px solid var(--pink-border);
  border-radius: 999px;
  padding: 9px 18px;
  font-family: var(--font-editorial);
  font-size: clamp(13px, 3.4vw, 14.5px);
  font-weight: 500;
"@

$css = $css.Replace($targetBtnFlip, $replaceBtnFlip)

[System.IO.File]::WriteAllText("$PSScriptRoot\..\style.css", $css, [System.Text.Encoding]::UTF8)
Write-Host "Updated style.css successfully for v9!"
