# scratch/test_refined_filter.ps1
function isContentInappropriateRefined($text) {
  if (-not $text) { return $false }
  $raw = $text.ToLower()
  $normalized = $raw.Normalize([System.Text.NormalizationForm]::FormD)
  $normalized = [regex]::Replace($normalized, "[\u0300-\u036f]", "")
  $normalized = $normalized.Replace("đ", "d").Replace("Đ", "d")

  # Xóa ký tự chen giữa (d.m, d_m, c-h-o)
  $collapsed = [regex]::Replace($normalized, "[\s\.\-_,\*#@!~;:+=\/\\|]+", "")

  # Regex cụ thể cho tiếng Việt (dùng cụm từ chính xác để không bao giờ chặn nhầm từ bình thường)
  $toxicPatterns = @(
    '\b(dm|dcm|dkm|đm|đcm|đkm|vcl|vkl|clm|đụ|địt|lồn|cặc|buồi|đéo)\b',
    '\b(con cho|do cho|thang cho|oc cho|cho de|cho chet|bon cho|con chó|đồ chó|thằng chó|óc chó|chó đẻ|chó chết|bọn chó)\b',
    '\b(do ngu|thang ngu|con ngu|ngu ngoc|ngu dot|dan don|đồ ngu|thằng ngu|con ngu|ngu ngốc|ngu dốt|đần độn)\b',
    '\b(suc vat|khon nan|rac ruoi|bien di|cut di|súc vật|khốn nạn|rác rưởi|biến đi|cút đi|chet di|chết đi)\b',
    '\b(con di|cave|gai bao|con đĩ)\b',
    '\b(fuck|shit|bitch|asshole|cunt|bastard)\b'
  )

  foreach ($pattern in $toxicPatterns) {
    if ($raw -match $pattern -or $normalized -match $pattern) {
      return $true
    }
  }

  # Quét từ khóa bị nén (chỉ các từ chửi đặc trưng, KHÔNG bao gồm từ thường như 'cho', 'cac', 'buoi', 'lon')
  $collapsedKeywords = @(
    "ditme", "duma", "lonme", "sucvat", "khonnan", "occho", "dongu", "cutdi", "biendi",
    "dcm", "dkm", "vcl", "vkl", "clm", "chetme"
  )
  foreach ($kw in $collapsedKeywords) {
    if ($collapsed.Contains($kw)) {
      return $true
    }
  }

  # Chặn spam ký tự lặp vô nghĩa (ví dụ aaaaaaa, ???????)
  if ($raw -match '(.)\1{6,}') {
    return $true
  }

  return $false
}

$goodCases = @(
  "Chúc mừng tốt nghiệp",
  "Chúc cho Tú luôn thành công",
  "Hẹn gặp ở buổi lễ tốt nghiệp nhé",
  "Chúc các bạn luôn vui vẻ",
  "Bạn thật là tuyệt vời",
  "Chúc bạn ngày càng lớn khôn",
  "Chuc mung tot nghiep nha",
  "Dành trọn vẹn tình cảm cho bạn",
  "Thương chúc Tú mọi điều tốt đẹp nhất"
)

$badCases = @(
  "Đồ ngu ngốc",
  "con chó này",
  "vcl luôn",
  "d.c.m m",
  "cút đi",
  "fuck you",
  "óc chó",
  "súc vật thật sự"
)

Write-Host "--- TESTING GOOD CASES (All should be FALSE) ---"
$goodFail = 0
foreach ($tc in $goodCases) {
  $res = isContentInappropriateRefined($tc)
  if ($res) {
    Write-Host "FAIL: '$tc' was wrongly blocked!" -ForegroundColor Red
    $goodFail++
  } else {
    Write-Host "PASS: '$tc' is allowed" -ForegroundColor Green
  }
}

Write-Host "`n--- TESTING BAD CASES (All should be TRUE) ---"
$badFail = 0
foreach ($tc in $badCases) {
  $res = isContentInappropriateRefined($tc)
  if (-not $res) {
    Write-Host "FAIL: '$tc' was NOT blocked!" -ForegroundColor Red
    $badFail++
  } else {
    Write-Host "PASS: '$tc' was correctly blocked" -ForegroundColor Green
  }
}

Write-Host "`nResult: Good Fails=$goodFail, Bad Fails=$badFail"
