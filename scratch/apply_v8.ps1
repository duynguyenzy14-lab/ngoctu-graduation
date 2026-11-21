# apply_v8.ps1
$ErrorActionPreference = "Stop"

# -------------------------------------------------------------
# 1. Update index.html
# -------------------------------------------------------------
$html = Get-Content -Path "index.html" -Raw -Encoding UTF8

# 1.1 "A little moment to remember ♡" => "A little moments to remember ♡"
$html = $html -replace 'A little moment to remember ♡', 'A little moments to remember ♡'

# 1.2 Bỏ dấu "!" trong thư mời
$html = $html -replace 'đáng nhớ nhé! ♡', 'đáng nhớ nhé ♡'

[System.IO.File]::WriteAllText("$PSScriptRoot\..\index.html", $html, [System.Text.Encoding]::UTF8)
Write-Host "Updated index.html successfully!"

# -------------------------------------------------------------
# 2. Update style.css
# -------------------------------------------------------------
$css = Get-Content -Path "style.css" -Raw -Encoding UTF8

# 2.1 Photo container aspect-ratio to 2/3 (full uncropped photo)
$targetPhotoContainer = @"
.photo-container {
  width: 100%;
  aspect-ratio: 4/5;
"@
$replacePhotoContainer = @"
.photo-container {
  width: 100%;
  aspect-ratio: 2/3;
"@
$css = $css.Replace($targetPhotoContainer, $replacePhotoContainer)

# Also adjust polaroid max-width slightly for vertical balance
$css = $css -replace 'max-width: clamp\(250px, 68vw, 290px\);', 'max-width: clamp(235px, 64vw, 275px);'

# 2.2 TP. Hồ Chí Minh, ngày 28 tháng 11 năm 2026 => chữ thẳng (normal)
$targetPlaceDate = @"
.letter-place-date {
  font-family: var(--font-editorial);
  font-style: italic;
"@
$replacePlaceDate = @"
.letter-place-date {
  font-family: var(--font-editorial);
  font-style: normal;
"@
$css = $css.Replace($targetPlaceDate, $replacePlaceDate)

# 2.3 "Ngọc Tú" => nhỏ size lại nha
$targetSignature = @"
.letter-signature {
  font-family: var(--font-editorial);
  font-size: clamp(19px, 5vw, 23px);
"@
$replaceSignature = @"
.letter-signature {
  font-family: var(--font-editorial);
  font-size: clamp(16px, 4.2vw, 18.5px);
"@
$css = $css.Replace($targetSignature, $replaceSignature)

# 2.4 "Hẹn gặp người thương" => in đậm nha (font-weight: 700)
$targetFarewellTitle = @"
.farewell-main-title {
  font-family: var(--font-editorial);
  font-size: clamp(15.5px, 3.8vw, 17.5px);
  font-weight: 500;
"@
$replaceFarewellTitle = @"
.farewell-main-title {
  font-family: var(--font-editorial);
  font-size: clamp(15.5px, 3.8vw, 17.5px);
  font-weight: 700;
"@
$css = $css.Replace($targetFarewellTitle, $replaceFarewellTitle)

[System.IO.File]::WriteAllText("$PSScriptRoot\..\style.css", $css, [System.Text.Encoding]::UTF8)
Write-Host "Updated style.css successfully!"

# -------------------------------------------------------------
# 3. Update script.js
# -------------------------------------------------------------
$js = Get-Content -Path "script.js" -Raw -Encoding UTF8

# 3.1 Bỏ dấu "!" trong các lời nhắn cá nhân hóa của thư mời
$js = $js -replace 'đáng nhớ nhé! ♡', 'đáng nhớ nhé ♡'

# 3.2 Nâng cấp bộ lọc ảo chống haters thông minh (Multi-layer Anti-Hater Shield)
$oldFilterRegex = '(?s)// =+\s*3\.\s*BỘ LỌC ẢO NỘI DUNG TIÊU CỰC[\s\S]*?return false;\s*\}'
$newFilterCode = @'
// ================= 3. BỘ LỌC ẢO NỘI DUNG TIÊU CỰC & CHỐNG HATERS (MULTI-LAYER ANTI-HATER SHIELD) =================
function isContentInappropriate(text) {
  if (!text) return false;

  // 1. Chuẩn hóa chuỗi (bỏ dấu tiếng Việt, viết thường)
  const raw = text.toLowerCase();
  const normalized = raw
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/[đĐ]/g, "d");

  // Xóa các ký tự phân tách haters hay cố tình chèn (ví dụ: d.m, d_m, d-m, c.h.o, v.c.l)
  const collapsed = normalized.replace(/[\s\.\-_,\*#@!~;:+=\/\\|]+/g, "");

  // 2. Danh sách mẫu regex từ ngữ tiêu cực, thô tục, chửi bới, trù dập
  const toxicPatterns = [
    /\b(dm|dcm|dkm|đm|đcm|đkm|vcl|vkl|vl|cl|cc|clm|đụ|địt|dit|lồn|lon|cặc|cac|buồi|buoi|dái|dai|đéo|deo|me may|ba may|con me)\b/i,
    /\b(chó|cho|súc vật|suc vat|khốn nạn|khon nan|óc chó|oc cho|đồ điên|do dien|thần kinh|than kinh)\b/i,
    /\b(đồ ngu|ngu ngốc|ngu dốt|thằng ngu|con ngu|đần|dan don|hãm|ham lol|ham lon|chết|chet di|bien di|cút|cut di)\b/i,
    /\b(rác rưởi|rac ruoi|xấu xí|xau xi|mặt dày|mat day|vô duyên|vo duyen|đĩ|di thap|cave|pho)\b/i,
    /\b(fuck|shit|bitch|asshole|cunt|dick|pussy|idiot|stupid|bastard)\b/i
  ];

  for (const pattern of toxicPatterns) {
    if (pattern.test(raw) || pattern.test(normalized)) {
      return true;
    }
  }

  // 3. Quét các từ khóa bị nén (chống chiêu lách luật haters chèn dấu chấm/khoảng trắng)
  const collapsedKeywords = [
    "dm", "dcm", "dkm", "vcl", "vkl", "clm", "ditme", "duma", "du ma", "lonme",
    "buoi", "cac", "cho", "sucvat", "khonnan", "occho", "dongu", "cutdi", "biendi"
  ];
  for (const kw of collapsedKeywords) {
    if (collapsed.includes(kw)) {
      return true;
    }
  }

  // 4. Chặn spam ký tự vô nghĩa lặp lại quá 5 lần (ví dụ: aaaaaaa, ???????, !!!!!!!)
  if (/(.)\1{5,}/.test(raw)) {
    return true;
  }

  return false;
}
'@

$js = [System.Text.RegularExpressions.Regex]::Replace($js, $oldFilterRegex, $newFilterCode.Trim())

[System.IO.File]::WriteAllText("$PSScriptRoot\..\script.js", $js, [System.Text.Encoding]::UTF8)
Write-Host "Updated script.js successfully!"
