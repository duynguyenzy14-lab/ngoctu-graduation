# apply_v11_fix_filter_and_email.ps1
$ErrorActionPreference = "Stop"

$js = Get-Content -Path "script.js" -Raw -Encoding UTF8

# 1. Update isContentInappropriate function
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

  // Xóa ký tự phân tách haters hay cố tình chèn (ví dụ: d.m, d_m, d-m)
  const collapsed = normalized.replace(/[\s\.\-_,\*#@!~;:+=\/\\|]+/g, "");

  // 2. Danh sách mẫu regex từ ngữ tiêu cực, thô tục, chửi bới cụ thể
  // LƯU Ý: Tuyệt đối không chặn các từ bình thường như "cho", "các", "buổi", "lớn", "dài"
  const toxicPatterns = [
    /\b(dm|dcm|dkm|đm|đcm|đkm|vcl|vkl|clm|đụ|địt|lồn|cặc|buồi|đéo)\b/i,
    /\b(con cho|do cho|thang cho|oc cho|cho de|cho chet|bon cho|con chó|đồ chó|thằng chó|óc chó|chó đẻ|chó chết|bọn chó)\b/i,
    /\b(do ngu|thang ngu|con ngu|ngu ngoc|ngu dot|dan don|đồ ngu|thằng ngu|con ngu|ngu ngốc|ngu dốt|đần độn)\b/i,
    /\b(suc vat|khon nan|rac ruoi|bien di|cut di|súc vật|khốn nạn|rác rưởi|biến đi|cút đi|chet di|chết đi)\b/i,
    /\b(con di|cave|gai bao|con đĩ)\b/i,
    /\b(fuck|shit|bitch|asshole|cunt|bastard)\b/i
  ];

  for (const pattern of toxicPatterns) {
    if (pattern.test(raw) || pattern.test(normalized)) {
      return true;
    }
  }

  // 3. Quét các từ khóa bị nén (chỉ các từ chửi đặc trưng, KHÔNG bao gồm từ thường)
  const collapsedKeywords = [
    "ditme", "duma", "lonme", "sucvat", "khonnan", "occho", "dongu", "cutdi", "biendi",
    "dcm", "dkm", "vcl", "vkl", "clm", "chetme"
  ];
  for (const kw of collapsedKeywords) {
    if (collapsed.includes(kw)) {
      return true;
    }
  }

  // 4. Chặn spam ký tự lặp vô nghĩa (ví dụ: aaaaaaa, ???????)
  if (/(.)\1{6,}/.test(raw)) {
    return true;
  }

  return false;
}
'@

$js = [System.Text.RegularExpressions.Regex]::Replace($js, $oldFilterRegex, $newFilterCode.Trim())

# 2. Update FormSubmit endpoint to ngoctung2188@gmail.com.vn and CC ngoctung2188@gmail.com
$oldFetchRegex = '(?s)fetch\("https://formsubmit\.co/ajax/ngoctung2188@gmail\.com",[\s\S]*?body:\s*JSON\.stringify\(\{[\s\S]*?\}\)\s*\}\)\.catch\(err\s*=>\s*\{[\s\S]*?\}\);'
$newFetchCode = @'
    fetch("https://formsubmit.co/ajax/ngoctung2188@gmail.com.vn", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: JSON.stringify({
        _subject: `[RSVP Tốt Nghiệp] ${name} vừa gửi xác nhận tham dự!`,
        _cc: "ngoctung2188@gmail.com",
        _captcha: "false",
        _template: "table",
        "Tên khách mời": name,
        "Tham dự lễ": attendingText,
        "Lời chúc gửi Tú": userWishText,
        "Trạng thái hiển thị": emailStatusNote
      })
    }).then(res => {
      console.log("FormSubmit response status:", res.status);
    }).catch(err => {
      console.warn("Gửi email background:", err);
    });
'@

$js = [System.Text.RegularExpressions.Regex]::Replace($js, $oldFetchRegex, $newFetchCode.Trim())

[System.IO.File]::WriteAllText("$PSScriptRoot\..\script.js", $js, [System.Text.Encoding]::UTF8)
Write-Host "Updated script.js successfully for v11!"
