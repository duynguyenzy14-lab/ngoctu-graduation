$utf8 = [System.Text.UTF8Encoding]::new($false)
$cssFile = "graduation_files\style.css"
$css = [System.IO.File]::ReadAllText($cssFile, [System.Text.Encoding]::UTF8)

# Normalize line endings to LF
$css = $css.Replace("`r`n", "`n")

# Replace from /* ================= 4. TRANG CUỐI - CHIA 2 PHẦN to before /* Nơ NO 2fixed
$startBoard = $css.IndexOf("/* ================= 4. TRANG CUỐI - CHIA 2 PHẦN")
$endBoard = $css.IndexOf("/* Nơ NO 2fixed", $startBoard)

$newBoardSection = @'
/* ================= 4. TRANG CUỐI - CHIA 2 PHẦN: THIỆP BÊN TRÁI, SẢNH LỜI CHÚC BÊN PHẢI ================= */
.board {
  display: grid;
  grid-template-columns: 1fr;
  gap: 28px;
  width: 100%;
  max-width: 1140px;
  margin: 0 auto;
}
@media (min-width: 980px) {
  .board {
    grid-template-columns: repeat(2, minmax(0, 1fr));
    align-items: stretch;
    gap: clamp(24px, 2.8vw, 36px);
  }
}
.board > * {
  width: 100%;
  min-width: 0;
}

/* Thiệp phản hồi bên trái: cân bằng kích thước, giãn dòng gọn gàng */
.rsvp-paper {
  position: relative;
  margin: 0;
  width: 100%;
  height: 100%;
  box-sizing: border-box;
  font-family: var(--font);
  padding: clamp(20px, 2.4vw, 30px);
  background-color: #FFFDFC;
  border: 1.5px solid #F8D3E2;
  border-radius: clamp(20px, 2.8vw, 28px) !important;
  box-shadow: 0 30px 60px -30px rgba(120, 20, 60, .22), inset 0 0 0 1px rgba(255, 182, 193, 0.4) !important;
  overflow: visible;
  display: flex;
  flex-direction: column;
}

'@.Replace("`r`n", "`n")

if ($startBoard -ge 0 -and $endBoard -gt $startBoard) {
    $css = $css.Substring(0, $startBoard) + $newBoardSection + $css.Substring($endBoard)
    Write-Output "Board section replaced."
} else {
    Write-Output "ERROR: Board section not found."
}

# Now replace from /* Phần đầu thiệp: to before .ticket {
$startHeader = $css.IndexOf("/* Phần đầu thiệp:")
$endHeader = $css.IndexOf(".ticket {", $startHeader)

$newFormSection = @'
/* Phần đầu thiệp: khoảng cách cân đối, khoảng cách dòng thu gọn hài hòa */
.rsvp-header {
  margin-bottom: 8px;
  padding-right: clamp(65px, 11vw, 95px);
}
@media (max-width: 600px) {
  .rsvp-header {
    margin-bottom: 6px;
    padding-right: clamp(45px, 12vw, 75px);
  }
}

/* Dòng 1: Badge 'Your little reply' */
.rsvp-badge {
  margin-bottom: 6px;
}
.rsvp-badge span {
  display: inline-block;
  font-family: var(--font);
  font-weight: 600;
  font-size: 11px;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: #FFFFFF;
  background: linear-gradient(135deg, #FF69B4 0%, #E0266B 100%);
  padding: 4px 12px;
  border-radius: 999px;
  box-shadow: 0 3px 10px rgba(224, 38, 107, 0.25);
}

/* Dòng chữ: 'Điền một chút thông tin để Ngọc Tú đón tiếp thật chu đáo nha' */
.rsvp-subtitle {
  font-family: var(--font);
  font-weight: 600;
  font-size: clamp(13px, 0.8vw + 8.5px, 15px);
  line-height: 1.35;
  color: var(--volt);
  margin: 0;
}

form {
  display: grid;
  gap: 8px;
}

/* Các nhóm trường thông tin */
.form-group {
  display: flex;
  flex-direction: column;
  gap: 3px;
}

/* Nhãn trường: font thiệp, tone hồng dâu */
.form-label {
  font-family: var(--font);
  font-weight: 600;
  font-size: 13px;
  line-height: 1.25;
  color: var(--volt);
  letter-spacing: -0.01em;
  display: flex;
  align-items: center;
  gap: 3px;
  margin: 0;
}

.form-label .req {
  color: var(--volt);
  font-weight: 700;
  font-size: 13px;
}

/* Ô nhập liệu: bo tròn viền hồng mỏng tinh tế */
.field {
  width: 100%;
  box-sizing: border-box;
  font-family: var(--font);
  font-size: 14px;
  line-height: 1.3;
  padding: 8px 14px;
  border-radius: 12px;
  border: 1.5px solid #F8B3CD;
  color: var(--ink);
  background: #FFFFFF;
  box-shadow: 0 1px 4px rgba(232, 39, 94, 0.03);
  transition: border-color .2s, box-shadow .2s;
}

.field::placeholder {
  color: #C08DA3;
  font-weight: 400;
}

.field:focus {
  outline: none;
  border-color: var(--volt);
  background: #FFFDFE;
  box-shadow: 0 0 0 3px rgba(232, 39, 94, 0.15);
}

/* Ô xổ ra lựa chọn: bo tròn viền hồng mỏng có mũi tên xổ xuống */
.select-wrap {
  position: relative;
  width: 100%;
}

.select-field {
  appearance: none;
  -webkit-appearance: none;
  -moz-appearance: none;
  cursor: pointer;
  padding: 8px 14px;
  padding-right: 36px;
  font-size: 14px;
  line-height: 1.3;
  background-color: #FFFFFF;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='14' height='10' viewBox='0 0 14 10' fill='none'%3E%3Cpath d='M1.5 2L7 7.5L12.5 2' stroke='%23E8275E' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 14px center;
  background-size: 11px 8px;
}

.select-field option {
  padding: 10px 14px;
  font-family: var(--font);
  font-size: 14px;
  color: var(--ink);
  background: #FFFFFF;
}

textarea.field {
  resize: vertical;
  min-height: 60px;
  line-height: 1.35;
  padding: 8px 14px;
}

.check {
  display: flex;
  gap: 8px;
  align-items: center;
  font-size: 12.5px;
  line-height: 1.35;
  color: var(--ink);
  cursor: pointer;
  margin-top: 1px;
}
.check input {
  flex: 0 0 15px;
  width: 15px;
  height: 15px;
  margin: 0;
  accent-color: var(--volt);
}

.send {
  justify-self: start;
  font: 600 14.5px var(--font);
  padding: 9px 24px;
  border-radius: 999px;
  border: 0;
  background: linear-gradient(135deg, #FF69B4, #E0266B);
  color: #fff;
  cursor: pointer;
  box-shadow: 0 4px 14px rgba(255, 64, 129, .35);
  transition: transform .2s, opacity .2s, box-shadow .2s;
  margin-top: 2px;
}
.send:hover { box-shadow: 0 6px 18px rgba(255, 64, 129, .5); }
.send:active { transform: scale(.97); }
.send:disabled { opacity: .6; cursor: progress; }
.err { margin: 0; color: #fff; background: rgba(255, 90, 90, .18); border: 1px solid rgba(255, 120, 120, .4); padding: 8px 12px; border-radius: 10px; font-size: 14px; }

'@.Replace("`r`n", "`n")

if ($startHeader -ge 0 -and $endHeader -gt $startHeader) {
    $css = $css.Substring(0, $startHeader) + $newFormSection + $css.Substring($endHeader)
    Write-Output "Form section replaced."
} else {
    Write-Output "ERROR: Form section not found."
}

# Now replace from /* Sảnh lời chúc: to end of .gb rules
$startGb = $css.IndexOf("/* Sảnh lời chúc:")
$endGb = $css.IndexOf("footer {", $startGb)

$newGbSection = @'
/* Sảnh lời chúc: cân bằng hoàn hảo kích thước với thiệp bên trái */
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
.gb .gb-ticker {
  margin: 0 0 10px;
  overflow: hidden;
  -webkit-mask-image: linear-gradient(90deg, transparent, #000 8%, #000 92%, transparent);
  mask-image: linear-gradient(90deg, transparent, #000 8%, #000 92%, transparent);
}
.gb .gb-card {
  position: relative;
  overflow: hidden;
  border: 1.5px dashed #F8CADB;
  border-radius: 16px;
  padding: clamp(16px, 2vw, 24px);
  flex: 1;
  min-height: 170px;
  display: grid;
  grid-template-rows: 1fr auto;
  gap: 14px;
  background: #FFF5F8;
}
.gb .gb-tt { color: var(--slate); }
.gb .gb-tt b { color: var(--volt); }
.gb .gb-quote {
  margin: 0;
  font: 600 clamp(17px, 2vw, 23px)/1.4 var(--serif);
  letter-spacing: .01em;
  color: var(--ink);
  overflow-wrap: anywhere;
}
.gb .gb-who small { color: var(--slate); }
.gb .gb-bar { background: var(--volt); opacity: .65; }
.gb .gb-nav {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 14px;
  margin-top: 10px;
  font: 600 13px var(--font);
}
.gb .gb-nav button { color: var(--slate); }
.gb .gb-nav button:hover { color: var(--volt); }
.gb .gb-nav span { color: var(--slate); }
.gb .gb-nav span b { color: var(--ink); }

'@.Replace("`r`n", "`n")

if ($startGb -ge 0 -and $endGb -gt $startGb) {
    $css = $css.Substring(0, $startGb) + $newGbSection + $css.Substring($endGb)
    Write-Output "Gb section replaced."
} else {
    Write-Output "ERROR: Gb section not found."
}

[System.IO.File]::WriteAllText($cssFile, $css.Replace("`n", "`r`n"), $utf8)
Write-Output "style.css updated."
