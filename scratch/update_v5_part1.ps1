$html = [System.IO.File]::ReadAllText("$PSScriptRoot\..\index.html", [System.Text.Encoding]::UTF8)

# 1. Update Page 1 button text
$html = $html -replace '<span class="flip-btn-text">Xem hành trình 4 năm</span>\s*<span class="flip-btn-icon" aria-hidden="true">🎞️ ➔</span>', '<span class="flip-btn-text">Lật sang trang nha</span> <span class="flip-btn-icon" aria-hidden="true">➔</span>'

# 2. Remove all corner page curls
$html = [System.Text.RegularExpressions.Regex]::Replace($html, '(?s)\s*<!-- GÓC LẬT TRANG SÁCH 3D.*?</div>\s*</div>', '')

# 3. Update Page 2 bottom buttons
$oldP2Btns = '(?s)<div class="page-action-row dual-action">\s*<button type="button" class="btn-flip-page btn-prev" data-flip-target="1"[^>]*>.*?<span class="flip-btn-text">Trang bìa</span>\s*</button>\s*<button type="button" class="btn-flip-page btn-next" data-flip-target="3"[^>]*>.*?<span class="flip-btn-text">Đọc thư mời</span>.*?</div>'
$newP2Btns = @'
<div class="page-action-row dual-action">
            <button type="button" class="btn-flip-page btn-prev" data-flip-target="1" aria-label="Quay lại trang trước">
              <span class="flip-btn-icon" aria-hidden="true">◀</span>
              <span class="flip-btn-text">Trang trước</span>
            </button>
            <button type="button" class="btn-flip-page btn-next" data-flip-target="3" aria-label="Lật sang trang tiếp theo">
              <span class="flip-btn-text">Trang tiếp theo</span>
              <span class="flip-btn-icon" aria-hidden="true">➔</span>
            </button>
          </div>
'@
$html = [System.Text.RegularExpressions.Regex]::Replace($html, $oldP2Btns, $newP2Btns)

# 4. Update Page 3 bottom buttons
$oldP3Btns = '(?s)<div class="page-action-row dual-action">\s*<button type="button" class="btn-flip-page btn-prev" data-flip-target="2"[^>]*>.*?<span class="flip-btn-text">Dải phim</span>\s*</button>\s*<button type="button" class="btn-flip-page btn-next" data-flip-target="4"[^>]*>.*?<span class="flip-btn-text">Chi tiết buổi lễ</span>.*?</div>'
$newP3Btns = @'
<div class="page-action-row dual-action">
            <button type="button" class="btn-flip-page btn-prev" data-flip-target="2" aria-label="Quay lại trang trước">
              <span class="flip-btn-icon" aria-hidden="true">◀</span>
              <span class="flip-btn-text">Trang trước</span>
            </button>
            <button type="button" class="btn-flip-page btn-next" data-flip-target="4" aria-label="Lật sang trang tiếp theo">
              <span class="flip-btn-text">Trang tiếp theo</span>
              <span class="flip-btn-icon" aria-hidden="true">➔</span>
            </button>
          </div>
'@
$html = [System.Text.RegularExpressions.Regex]::Replace($html, $oldP3Btns, $newP3Btns)

# 5. Update Address on Page 4
$html = $html.Replace('Số 97 Võ Văn Tần, Phường Võ Thị Sáu, Quận 3, TP.HCM', 'Số 97 Võ Văn Tần, Phường Xuân Hòa, TP. Hồ Chí Minh')

# 6. Update Google Maps to RSVP button on Page 4
$oldMaps = '(?s)<div class="details-action-wrap">\s*<a href="https://maps.app.goo.gl/ZjacVTJBH1mfbgay9"[^>]*>.*?</a>\s*</div>'
$newRsvpBtn = @'
<div class="details-action-wrap">
              <button type="button" class="btn-maps-action btn-next" data-flip-target="5" aria-label="Chuyển sang trang xác nhận tham dự">
                <span>💌 Xác nhận tham dự ➔</span>
              </button>
            </div>
'@
$html = [System.Text.RegularExpressions.Regex]::Replace($html, $oldMaps, $newRsvpBtn)

# 7. Update Page 4 bottom buttons
$oldP4Btns = '(?s)<div class="page-action-row dual-action">\s*<button type="button" class="btn-flip-page btn-prev" data-flip-target="3"[^>]*>.*?<span class="flip-btn-text">Đọc lại thư</span>\s*</button>\s*<button type="button" class="btn-flip-page btn-next" data-flip-target="1"[^>]*>.*?<span class="flip-btn-text">Về trang bìa</span>.*?</div>'
$newP4Btns = @'
<div class="page-action-row dual-action">
            <button type="button" class="btn-flip-page btn-prev" data-flip-target="3" aria-label="Quay lại trang trước">
              <span class="flip-btn-icon" aria-hidden="true">◀</span>
              <span class="flip-btn-text">Trang trước</span>
            </button>
            <button type="button" class="btn-flip-page btn-next" data-flip-target="5" aria-label="Lật sang trang tiếp theo">
              <span class="flip-btn-text">Trang tiếp theo</span>
              <span class="flip-btn-icon" aria-hidden="true">➔</span>
            </button>
          </div>
'@
$html = [System.Text.RegularExpressions.Regex]::Replace($html, $oldP4Btns, $newP4Btns)

Write-Host "Partial replacements done."
