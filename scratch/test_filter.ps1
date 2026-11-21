# test_filter.ps1
function isContentInappropriate($text) {
  if (-not $text) { return $false }
  $raw = $text.ToLower()
  $normalized = $raw.Normalize([System.Text.NormalizationForm]::FormD)
  $normalized = [regex]::Replace($normalized, "[\u0300-\u036f]", "")
  $normalized = $normalized.Replace("đ", "d").Replace("Đ", "d")

  $collapsed = [regex]::Replace($normalized, "[\s\.\-_,\*#@!~;:+=\/\\|]+", "")

  $toxicPatterns = @(
    '\b(dm|dcm|dkm|đm|đcm|đkm|vcl|vkl|vl|cl|cc|clm|đụ|địt|dit|lồn|lon|cặc|cac|buồi|buoi|dái|dai|đéo|deo|me may|ba may|con me)\b',
    '\b(chó|cho|súc vật|suc vat|khốn nạn|khon nan|óc chó|oc cho|đồ điên|do dien|thần kinh|than kinh)\b',
    '\b(đồ ngu|ngu ngốc|ngu dốt|thằng ngu|con ngu|đần|dan don|hãm|ham lol|ham lon|chết|chet di|bien di|cút|cut di)\b',
    '\b(rác rưởi|rac ruoi|xấu xí|xau xi|mặt dày|mat day|vô duyên|vo duyen|đĩ|di thap|cave|pho)\b',
    '\b(fuck|shit|bitch|asshole|cunt|dick|pussy|idiot|stupid|bastard)\b'
  )

  foreach ($pattern in $toxicPatterns) {
    if ($raw -match $pattern -or $normalized -match $pattern) {
      return $true
    }
  }

  $collapsedKeywords = @(
    "dm", "dcm", "dkm", "vcl", "vkl", "clm", "ditme", "duma", "du ma", "lonme",
    "buoi", "cac", "cho", "sucvat", "khonnan", "occho", "dongu", "cutdi", "biendi"
  )
  foreach ($kw in $collapsedKeywords) {
    if ($collapsed.Contains($kw)) {
      return $true
    }
  }

  return $false
}

$testCases = @(
  "Chúc mừng tốt nghiệp",
  "Chúc cho Tú luôn thành công",
  "Hẹn gặp ở buổi lễ tốt nghiệp nhé",
  "Chúc các bạn luôn vui vẻ",
  "Bạn thật là tuyệt vời",
  "Chúc bạn ngày càng lớn khôn",
  "Chuc mung tot nghiep nha"
)

foreach ($tc in $testCases) {
  $res = isContentInappropriate($tc)
  Write-Host "Sentence: '$tc' -> Inappropriate? $res"
}
