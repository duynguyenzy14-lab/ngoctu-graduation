# apply_slide6_and_interleave.ps1
$ErrorActionPreference = "Stop"

# -------------------------------------------------------------
# 1. Update style.css
# -------------------------------------------------------------
$cssContent = Get-Content -Path "style.css" -Raw -Encoding UTF8

# Turn details-main-title ("LỄ TỐT NGHIỆP ĐẠI HỌC 2026") into tone hồng
$cssContent = $cssContent -replace '(\.details-main-title\s*\{[^}]*color:\s*)var\(--text-dark\);', '$1var(--pink-accent);'
$cssContent = $cssContent -replace '(\.details-main-title\s*\{[^}]*color:\s*)#2B2125;', '$1var(--pink-accent);'

# Add styles for Section 06 (Farewell slide & Wishes board) if not already added
if ($cssContent -notmatch '\.wishes-board-card') {
  $slide6Css = @"

/* ================= 12. TRANG 6: HẸN GẶP NGƯỜI THƯƠNG & LỜI CHÚC (FAREWELL SLIDE) ================= */
.farewell-header {
  margin-bottom: 12px;
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.farewell-badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 4px 14px;
  background: #FFF0F6;
  border: 1px solid rgba(232, 39, 94, 0.25);
  border-radius: 999px;
  font-family: var(--font-editorial);
  font-size: 11px;
  font-weight: 700;
  letter-spacing: 0.08em;
  color: var(--pink-accent);
  text-transform: uppercase;
  margin-bottom: 6px;
}

.farewell-main-title {
  font-family: var(--font-editorial);
  font-size: clamp(20px, 5.2vw, 24px);
  font-weight: 800;
  color: var(--pink-accent);
  letter-spacing: 0.02em;
  margin: 0 0 4px 0;
  line-height: 1.25;
}

.farewell-date {
  font-family: var(--font-editorial);
  font-size: clamp(16px, 4.2vw, 18px);
  font-weight: 700;
  color: #2B2125;
  letter-spacing: 0.08em;
  margin: 0 0 6px 0;
}

.farewell-sub-text {
  font-family: var(--font-editorial);
  font-size: clamp(12.5px, 3.4vw, 13.5px);
  color: var(--text-muted);
  margin: 0;
  line-height: 1.5;
}

.wishes-board-card {
  background: #FFFFFF;
  border-radius: 14px;
  padding: 14px 12px;
  border: 1px solid rgba(232, 39, 94, 0.14);
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.04);
  margin-top: 10px;
  margin-bottom: 14px;
  text-align: left;
}

.wishes-board-header {
  display: flex;
  align-items: center;
  gap: 6px;
  font-family: var(--font-editorial);
  font-size: 13.5px;
  font-weight: 700;
  color: #B51E4E;
  border-bottom: 1px dashed rgba(232, 39, 94, 0.2);
  padding-bottom: 8px;
  margin-bottom: 10px;
}

.wishes-board-header .wishes-icon {
  font-size: 15px;
}

.wishes-board-header .wishes-title {
  letter-spacing: 0.02em;
}

.wishes-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
  max-height: 235px;
  overflow-y: auto;
  padding-right: 4px;
  scrollbar-width: thin;
  scrollbar-color: rgba(232, 39, 94, 0.3) transparent;
}

.wishes-list::-webkit-scrollbar {
  width: 4px;
}

.wishes-list::-webkit-scrollbar-thumb {
  background: rgba(232, 39, 94, 0.3);
  border-radius: 999px;
}

.wish-item {
  background: #FFF9FB;
  border: 1px solid rgba(232, 39, 94, 0.15);
  border-radius: 10px;
  padding: 9px 11px;
  transition: all 0.25s ease;
}

.wish-item.is-new {
  border-color: var(--pink-accent);
  background: #FFF0F6;
  box-shadow: 0 2px 10px rgba(232, 39, 94, 0.18);
}

.wish-meta {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 4px;
}

.wish-author {
  font-family: var(--font-editorial);
  font-size: 13px;
  font-weight: 700;
  color: #2B2125;
  display: flex;
  align-items: center;
  gap: 4px;
}

.wish-tag {
  font-family: var(--font-editorial);
  font-size: 10.5px;
  font-weight: 600;
  padding: 2px 7px;
  border-radius: 999px;
  background: #FFE4EE;
  color: #B51E4E;
}

.wish-content {
  font-family: var(--font-editorial);
  font-size: 12.5px;
  color: #4A3A40;
  line-height: 1.5;
  margin: 0;
}

"@
  $cssContent += $slide6Css
}

[System.IO.File]::WriteAllText("$PSScriptRoot\..\style.css", $cssContent, [System.Text.Encoding]::UTF8)
Write-Host "style.css updated successfully!"

# -------------------------------------------------------------
# 2. Update index.html
# -------------------------------------------------------------
$htmlContent = Get-Content -Path "index.html" -Raw -Encoding UTF8

# Update label: "Tên của bạn / Người thương:" => "Tên của bạn"
$htmlContent = $htmlContent -replace 'Tên của bạn / Người thương:', 'Tên của bạn:'

# Update Page 5 next button to flip to Page 6
$htmlContent = $htmlContent -replace '(<article class="book-page page-5"[\s\S]*?<button type="button" class="btn-flip-page btn-next" data-flip-target=")1(" aria-label="Quay về trang bìa">[\s\S]*?<span class="flip-btn-text">)Về trang bìa(</span>[\s\S]*?<span class="flip-btn-icon" aria-hidden="true">)🌸 ➔(</span>)', '$16$2Trang tiếp theo$3➔$4'

# Generate 36 interleaved photos:
$bgPics = @(
  @{ Path="./graduation_files/bg-pics/pic-01.jpg"; Class="is-landscape"; Alt="Khoảnh khắc OU" },
  @{ Path="./graduation_files/bg-pics/pic-02.jpg"; Class="is-landscape"; Alt="Khoảnh khắc OU" },
  @{ Path="./graduation_files/bg-pics/pic-03.jpg"; Class="is-landscape"; Alt="Khoảnh khắc OU" },
  @{ Path="./graduation_files/bg-pics/pic-04.jpg"; Class="is-landscape"; Alt="Khoảnh khắc OU" },
  @{ Path="./graduation_files/bg-pics/pic-05.jpg"; Class="is-landscape"; Alt="Khoảnh khắc OU" },
  @{ Path="./graduation_files/bg-pics/pic-06.jpg"; Class="is-portrait"; Alt="Khoảnh khắc OU" },
  @{ Path="./graduation_files/bg-pics/pic-08.jpg"; Class="is-square"; Alt="Khoảnh khắc OU" },
  @{ Path="./graduation_files/bg-pics/pic-09.jpg"; Class="is-landscape"; Alt="Khoảnh khắc OU" },
  @{ Path="./graduation_files/bg-pics/pic-10.jpg"; Class="is-landscape"; Alt="Khoảnh khắc OU" },
  @{ Path="./graduation_files/bg-pics/pic-11.jpg"; Class="is-portrait is-portrait-23"; Alt="Khoảnh khắc OU" },
  @{ Path="./graduation_files/bg-pics/pic-12.jpg"; Class="is-landscape is-landscape-wide"; Alt="Khoảnh khắc OU" },
  @{ Path="./graduation_files/bg-pics/pic-13.jpg"; Class="is-landscape"; Alt="Khoảnh khắc OU" },
  @{ Path="./graduation_files/bg-pics/pic-14.jpg"; Class="is-portrait"; Alt="Khoảnh khắc OU" },
  @{ Path="./graduation_files/bg-pics/pic-15.jpg"; Class="is-landscape"; Alt="Khoảnh khắc OU" },
  @{ Path="./graduation_files/bg-pics/pic-16.jpg"; Class="is-landscape"; Alt="Khoảnh khắc OU" },
  @{ Path="./graduation_files/bg-pics/pic-17.jpg"; Class="is-landscape"; Alt="Khoảnh khắc OU" },
  @{ Path="./graduation_files/bg-pics/pic-18.jpg"; Class="is-landscape"; Alt="Khoảnh khắc OU" },
  @{ Path="./graduation_files/bg-pics/pic-19.jpg"; Class="is-portrait"; Alt="Khoảnh khắc OU" },
  @{ Path="./graduation_files/bg-pics/pic-20.jpg"; Class="is-landscape"; Alt="Khoảnh khắc OU" },
  @{ Path="./graduation_files/bg-pics/pic-21.jpg"; Class="is-landscape"; Alt="Khoảnh khắc OU" }
)

$preGrad = @(
  @{ Path="./graduation_files/photos/lvhq0003-800.jpg"; Class="is-landscape"; Alt="Kỷ yếu tốt nghiệp" },
  @{ Path="./graduation_files/photos/lvhq0066-800.jpg"; Class="is-landscape"; Alt="Kỷ yếu tốt nghiệp" },
  @{ Path="./graduation_files/photos/lvhq0101-800.jpg"; Class="is-portrait"; Alt="Kỷ yếu tốt nghiệp" },
  @{ Path="./graduation_files/photos/lvhq0321-800.jpg"; Class="is-portrait"; Alt="Kỷ yếu tốt nghiệp" },
  @{ Path="./graduation_files/photos/lvhq0336-800.jpg"; Class="is-landscape"; Alt="Kỷ yếu tốt nghiệp" },
  @{ Path="./graduation_files/photos/lvhq0357-800.jpg"; Class="is-landscape"; Alt="Kỷ yếu tốt nghiệp" },
  @{ Path="./graduation_files/photos/lvhq0513-800.jpg"; Class="is-portrait"; Alt="Kỷ yếu tốt nghiệp" },
  @{ Path="./graduation_files/photos/lvhq0556-800.jpg"; Class="is-portrait"; Alt="Kỷ yếu tốt nghiệp" },
  @{ Path="./graduation_files/photos/lvhq0638-800.jpg"; Class="is-portrait"; Alt="Kỷ yếu tốt nghiệp" },
  @{ Path="./graduation_files/photos/lvhq0655-800.jpg"; Class="is-portrait"; Alt="Kỷ yếu tốt nghiệp" },
  @{ Path="./graduation_files/photos/lvhq0660-800.jpg"; Class="is-portrait"; Alt="Kỷ yếu tốt nghiệp" },
  @{ Path="./graduation_files/photos/lvhq0673-800.jpg"; Class="is-landscape"; Alt="Kỷ yếu tốt nghiệp" },
  @{ Path="./graduation_files/photos/lvhq0783-800.jpg"; Class="is-landscape"; Alt="Kỷ yếu tốt nghiệp" },
  @{ Path="./graduation_files/photos/lvhq0799-800.jpg"; Class="is-portrait"; Alt="Kỷ yếu tốt nghiệp" },
  @{ Path="./graduation_files/photos/lvhq9982-800.jpg"; Class="is-landscape"; Alt="Kỷ yếu tốt nghiệp" },
  @{ Path="./graduation_files/photos/lvhq9987-800.jpg"; Class="is-portrait"; Alt="Kỷ yếu tốt nghiệp" }
)

$interleaved = [System.Collections.Generic.List[object]]::new()
$bgI = 0
$pgI = 0
while ($bgI -lt $bgPics.Count -or $pgI -lt $preGrad.Count) {
  if ($bgI -lt $bgPics.Count) {
    $interleaved.Add($bgPics[$bgI])
    $bgI++
  }
  # Xen kẽ thêm 1 ảnh bg-pics ở vị trí phân bổ đều
  if (($bgI -eq 5 -or $bgI -eq 10 -or $bgI -eq 15 -or $bgI -eq 20) -and $bgI -lt $bgPics.Count) {
    $interleaved.Add($bgPics[$bgI])
    $bgI++
  }
  if ($pgI -lt $preGrad.Count) {
    $interleaved.Add($preGrad[$pgI])
    $pgI++
  }
}

# Xây dựng mã HTML cho film-marquee-track
$trackHtml = [System.Text.StringBuilder]::new()
$trackHtml.AppendLine('                <div class="film-marquee-track" id="filmMarqueeTrack">')
$trackHtml.AppendLine('                  <!-- DẢI 36 ẢNH XEN KẼ GIỮA HÀNH TRÌNH ĐẠI HỌC VÀ KỶ YẾU PRE-GRADUATION -->')

for ($i = 0; $i -lt $interleaved.Count; $i++) {
  $item = $interleaved[$i]
  $loading = if ($i -lt 4) { "eager" } else { "lazy" }
  $trackHtml.AppendLine("                  <div class=""film-frame-item $($item.Class)""><img src=""$($item.Path)"" alt=""$($item.Alt)"" class=""film-photo"" loading=""$loading""></div>")
}

$trackHtml.AppendLine('                  <!-- BẢN SAO TIẾP NỐI ĐỂ CUỘN LIỀN MẠCH VÔ TẬN -->')
for ($i = 0; $i -lt $interleaved.Count; $i++) {
  $item = $interleaved[$i]
  $trackHtml.AppendLine("                  <div class=""film-frame-item $($item.Class)"" aria-hidden=""true""><img src=""$($item.Path)"" alt="""" class=""film-photo"" loading=""lazy""></div>")
}
$trackHtml.AppendLine('                </div>')

# Thay thế toàn bộ khối film-marquee-track
$trackRegex = '(?s)<div class="film-marquee-track" id="filmMarqueeTrack">[\s\S]*?</div>\s*</div>\s*<!-- Hàng lỗ perforation phía dưới'
$trackReplacement = $trackHtml.ToString().TrimEnd() + "`n              </div>`n              <!-- Hàng lỗ perforation phía dưới"

$htmlContent = [System.Text.RegularExpressions.Regex]::Replace($htmlContent, $trackRegex, $trackReplacement)

# Thêm Trang 6 (Slide cuối: "Hẹn gặp người thương" 28/11/2026 & Sổ lưu bút) nếu chưa có
if ($htmlContent -notmatch 'id="page6"') {
  $page6Html = @"

      <!-- ================= TRANG 6: SECTION 06 - HẸN GẶP NGƯỜI THƯƠNG & SỔ LƯU BÚT ================= -->
      <article class="book-page page-6" id="page6" aria-label="Trang 6 - Hẹn gặp người thương & Sổ lưu bút">
        <div class="page-card-dashed">
          
          <header class="farewell-header">
            <div class="farewell-badge">
              <span>🌸 HẸN GẶP NGƯỜI THƯƠNG</span>
            </div>
            <h2 class="farewell-main-title">Hẹn gặp người thương</h2>
            <p class="farewell-date">28/11/2026</p>
            <p class="farewell-sub-text">
              Cảm ơn bạn đã luôn là một phần thật đẹp trong thanh xuân của Tú ♡
            </p>
          </header>

          <!-- KHUNG LƯU GIỮ LỜI CHÚC CỦA MỌI NGƯỜI (WISHES GUESTBOOK) -->
          <div class="wishes-board-card">
            <div class="wishes-board-header">
              <span class="wishes-icon">💌</span>
              <span class="wishes-title">Lời chúc từ những người thương</span>
            </div>
            <div class="wishes-list" id="wishesList">
              <!-- Render động từ JavaScript -->
            </div>
          </div>

          <!-- NÚT ĐIỀU HƯỚNG TRANG 6 -->
          <div class="page-action-row dual-action">
            <button type="button" class="btn-flip-page btn-prev" data-flip-target="5" aria-label="Quay lại trang xác nhận">
              <span class="flip-btn-icon" aria-hidden="true">◀</span>
              <span class="flip-btn-text">Trang trước</span>
            </button>
            <button type="button" class="btn-flip-page btn-next" data-flip-target="1" aria-label="Quay về trang bìa">
              <span class="flip-btn-text">Về trang bìa</span>
              <span class="flip-btn-icon" aria-hidden="true">🌸 ➔</span>
            </button>
          </div>

        </div>
      </article>
"@
  # Thêm trước đóng </div id="bookViewport">
  $htmlContent = $htmlContent -replace '(\s*</div>\s*</main>)', "$page6Html`n    `$1"
}

[System.IO.File]::WriteAllText("$PSScriptRoot\..\index.html", $htmlContent, [System.Text.Encoding]::UTF8)
Write-Host "index.html updated successfully!"

# -------------------------------------------------------------
# 3. Update script.js
# -------------------------------------------------------------
$newJs = @'
/**
 * NGỌC TÚ – GRADUATION INVITATION 2026
 * 1. Multi-page 3D Mobile Book Flip (Page 1 -> 6)
 *    Page 1: Bìa Polaroid
 *    Page 2: Dải phim xen kẽ 35mm
 *    Page 3: Thư mời thân thương
 *    Page 4: Chi tiết lễ tốt nghiệp
 *    Page 5: Xác nhận tham dự (RSVP)
 *    Page 6: Hẹn gặp người thương & Sổ lưu bút (Wishes Board)
 * 2. Cảm ứng vuốt tay (Touch Swipe Left/Right) & nút điều hướng lật trang
 * 3. Chạm vào bìa để lật trang
 * 4. Cá nhân hóa lời nhắn khách mời (?to=Nhi, ?to=Khánh...)
 * 5. Tự động lưu & hiển thị lời chúc của bạn bè lên Sổ lưu bút
 */

// ================= DỮ LIỆU CÁ NHÂN HÓA KHÁCH MỜI =================
const GUEST_DATA = {
  "Nhi": {
    salutation: "Gửi Nhi thương mến,",
    message: "Cảm ơn Nhi vì đã luôn ở bên cạnh, lắng nghe và chia sẻ cùng Tú qua từng giai đoạn của thời sinh viên. Những buổi chuyện trò, những khoảnh khắc vui buồn có Nhi đồng hành đã làm cho những năm tháng thanh xuân của Tú trở nên trọn vẹn và đáng nhớ hơn bao giờ hết.\n\nSáng Thứ Bảy, ngày 28.11, mình sẽ chính thức khép lại hành trình 4 năm tại OU. Ngọc Tú rất mong được gặp mọi người, cùng chung vui và lưu lại thật nhiều khoảnh khắc đáng nhớ nhé! ♡"
  },
  "Khánh": {
    salutation: "Gửi Khánh thương mến,",
    message: "Bốn năm đại học trôi qua thật nhanh với biết bao kỷ niệm và thử thách. Cảm ơn Khánh vì đã luôn là một người bạn tuyệt vời, luôn đồng hành và tiếp thêm năng lượng tích cực cho Tú trong suốt chặng đường vừa qua.\n\nSáng Thứ Bảy, ngày 28.11, mình sẽ chính thức khép lại hành trình 4 năm tại OU. Ngọc Tú rất mong được gặp mọi người, cùng chung vui và lưu lại thật nhiều khoảnh khắc đáng nhớ nhé! ♡"
  },
  "Phát": {
    salutation: "Gửi Phát thương mến,",
    message: "Nhìn lại chặng đường 4 năm đại học đã qua, Tú thật sự biết ơn vì luôn có Phát đồng hành và ủng hộ. Cảm ơn những lần hỗ trợ nhiệt tình, những cuộc trò chuyện và sự chân thành mà Phát đã dành cho Tú.\n\nSáng Thứ Bảy, ngày 28.11, mình sẽ chính thức khép lại hành trình 4 năm tại OU. Ngọc Tú rất mong được gặp mọi người, cùng chung vui và lưu lại thật nhiều khoảnh khắc đáng nhớ nhé! ♡"
  },
  "Trang": {
    salutation: "Gửi Trang yêu quý,",
    message: "Cảm ơn Trang vì đã là một phần thật dịu dàng và ấm áp trong những năm tháng đại học của Tú. Cảm ơn những sẻ chia, những nụ cười và sự thấu hiểu mà Trang luôn dành cho Tú suốt thời gian qua.\n\nSáng Thứ Bảy, ngày 28.11, mình sẽ chính thức khép lại hành trình 4 năm tại OU. Ngọc Tú rất mong được gặp mọi người, cùng chung vui và lưu lại thật nhiều khoảnh khắc đáng nhớ nhé! ♡"
  },
  "Duy": {
    salutation: "Gửi Duy thương mến,",
    message: "Thấm thoát mà 4 năm đại học đã đến đích rồi. Cảm ơn Duy vì đã luôn ở đó, luôn là người bạn đồng hành đáng tin cậy và chia sẻ cùng Tú qua từng mùa thi, từng bài thuyết trình và những deadline căng thẳng.\n\nSáng Thứ Bảy, ngày 28.11, mình sẽ chính thức khép lại hành trình 4 năm tại OU. Ngọc Tú rất mong được gặp mọi người, cùng chung vui và lưu lại thật nhiều khoảnh khắc đáng nhớ nhé! ♡"
  },
  "Thuận": {
    salutation: "Gửi Thuận thương mến,",
    message: "Cảm ơn Thuận vì đã luôn đồng hành, giúp đỡ và mang lại thật nhiều niềm vui trong suốt những năm tháng thanh xuân vừa qua của Tú. Nhờ có những người bạn như Thuận mà chặng đường đại học của Tú đã trở nên vô cùng ý nghĩa và nhiều màu sắc.\n\nSáng Thứ Bảy, ngày 28.11, mình sẽ chính thức khép lại hành trình 4 năm tại OU. Ngọc Tú rất mong được gặp mọi người, cùng chung vui và lưu lại thật nhiều khoảnh khắc đáng nhớ nhé! ♡"
  }
};

// ================= DỮ LIỆU LỜI CHÚC MẪU BAN ĐẦU CHO SỔ LƯU BÚT =================
const DEFAULT_WISHES = [
  {
    name: "Nhi",
    attending: "Sẽ đến nhaa! 💖",
    message: "Chúc mừng tân cử nhân xinh đẹp của tui! Chúc Tú chặng đường mới luôn rực rỡ và hạnh phúc nha 🎓✨",
    time: "20/11/2026"
  },
  {
    name: "Khánh",
    attending: "Sẽ đến nhaa! 💖",
    message: "Bốn năm đại học thật nhiều kỷ niệm. Hẹn gặp Tú vào sáng 28.11 nha, nhất định phải chụp 1000 tấm ảnh! 📸",
    time: "19/11/2026"
  },
  {
    name: "Trang",
    attending: "Sẽ đến nhaa! 💖",
    message: "Tự hào về Tú lắm luôn. Ngày tốt nghiệp thật toả sáng nha cô gái của tụi mình ♡",
    time: "18/11/2026"
  },
  {
    name: "Duy",
    attending: "Sẽ đến nhaa! 💖",
    message: "Chúc mừng Ngọc Tú đã về đích xuất sắc! Chúc bạn tương lai thênh thang rộng mở nhé 🎉",
    time: "17/11/2026"
  }
];

// Biến điều hướng toàn cục
let currentPage = 1;
let isFlipping = false;
let flipToPageFn = null;

// ================= KHỞI TẠO DOM CONTENT LOADED =================
document.addEventListener("DOMContentLoaded", () => {
  initPersonalizedGreeting();
  initMobileBookFlip();
  initWishesBoard();
  initRsvpForm();
});

// ================= 1. CÁ NHÂN HÓA LỜI NHẮN THEO QUERY PARAM =================
function initPersonalizedGreeting() {
  const urlParams = new URLSearchParams(window.location.search);
  const rawGuestParam = urlParams.get("to") || urlParams.get("guest") || urlParams.get("name");

  if (rawGuestParam) {
    const guestName = rawGuestParam.trim();
    document.title = `${guestName} ơi, cùng Tú nhìn lại hành trình OU 2022–2026 🎓`;

    const elSalutation = document.getElementById("letterSalutation");
    const elContent = document.getElementById("letterContent");

    if (GUEST_DATA[guestName]) {
      if (elSalutation) elSalutation.textContent = GUEST_DATA[guestName].salutation;
      if (elContent) {
        const paragraphs = GUEST_DATA[guestName].message.split("\n\n");
        elContent.innerHTML = paragraphs.map((p, idx) => {
          const isHighlight = idx === paragraphs.length - 1;
          return `<p class="letter-paragraph ${isHighlight ? 'highlight-msg' : ''}">${p}</p>`;
        }).join("");
      }
    } else {
      if (elSalutation) elSalutation.textContent = `Gửi ${guestName} thương mến,`;
    }

    // Tự động điền tên vào Form RSVP
    const guestInput = document.getElementById("guestNameInput");
    if (guestInput && !guestInput.value) {
      guestInput.value = guestName;
    }
  }
}

// ================= 2. HỆ THỐNG LẬT SÁCH 3D ĐA TRANG (1 -> 6) =================
function initMobileBookFlip() {
  const bookViewport = document.getElementById("bookViewport");

  function flipToPage(targetPage) {
    if (isFlipping || targetPage === currentPage || targetPage < 1 || targetPage > 6 || !bookViewport) return;
    isFlipping = true;

    const fromPageEl = document.getElementById(`page${currentPage}`);
    const toPageEl = document.getElementById(`page${targetPage}`);

    const isForward = targetPage > currentPage;

    bookViewport.classList.remove("is-turning-forward", "is-turning-backward");
    bookViewport.classList.add(isForward ? "is-turning-forward" : "is-turning-backward");

    if (fromPageEl) fromPageEl.classList.add("is-turning-out");
    if (toPageEl) {
      toPageEl.classList.add("is-turning-in");
      toPageEl.classList.add("is-active");
    }

    window.scrollTo({ top: 0, behavior: "smooth" });

    setTimeout(() => {
      if (fromPageEl) {
        fromPageEl.classList.remove("is-active", "is-turning-out");
      }
      if (toPageEl) {
        toPageEl.classList.remove("is-turning-in");
      }
      bookViewport.classList.remove("is-turning-forward", "is-turning-backward");

      currentPage = targetPage;
      isFlipping = false;
    }, 650);
  }

  flipToPageFn = flipToPage;

  // 1. Lắng nghe các nút lật trang
  document.querySelectorAll("[data-flip-target]").forEach(btn => {
    btn.addEventListener("click", (e) => {
      e.preventDefault();
      e.stopPropagation();
      const target = parseInt(btn.getAttribute("data-flip-target"), 10);
      if (!isNaN(target)) {
        flipToPage(target);
      }
    });
  });

  // 2. Chạm vào bìa Trang 1 để lật sang Trang 2
  const page1Card = document.querySelector("#page1 .page-card-dashed");
  if (page1Card) {
    page1Card.addEventListener("click", (e) => {
      if (currentPage === 1 && !e.target.closest("button") && !e.target.closest("a")) {
        flipToPage(2);
      }
    });
  }

  // 3. Phím mũi tên bàn phím
  window.addEventListener("keydown", (e) => {
    if (e.key === "ArrowRight" || e.key === "PageDown") {
      flipToPage(currentPage + 1);
    } else if (e.key === "ArrowLeft" || e.key === "PageUp") {
      flipToPage(currentPage - 1);
    }
  });

  // 4. Cảm ứng vuốt tay trên điện thoại
  let touchStartX = 0;
  let touchStartY = 0;
  let touchEndX = 0;
  let touchEndY = 0;

  window.addEventListener("touchstart", (e) => {
    if (e.touches && e.touches.length > 0) {
      touchStartX = e.touches[0].clientX;
      touchStartY = e.touches[0].clientY;
    }
  }, { passive: true });

  window.addEventListener("touchend", (e) => {
    if (e.changedTouches && e.changedTouches.length > 0) {
      touchEndX = e.changedTouches[0].clientX;
      touchEndY = e.changedTouches[0].clientY;
      handleTouchSwipe();
    }
  }, { passive: true });

  function handleTouchSwipe() {
    const deltaX = touchEndX - touchStartX;
    const deltaY = touchEndY - touchStartY;

    if (Math.abs(deltaX) > 48 && Math.abs(deltaX) > Math.abs(deltaY) * 1.5) {
      if (deltaX < 0) {
        flipToPage(currentPage + 1);
      } else {
        flipToPage(currentPage - 1);
      }
    }
  }
}

// ================= 3. QUẢN LÝ SỔ LƯU BÚT (WISHES BOARD) =================
function getStoredWishes() {
  try {
    const raw = localStorage.getItem("ngoctu_graduation_wishes");
    if (raw) {
      const parsed = JSON.parse(raw);
      if (Array.isArray(parsed) && parsed.length > 0) {
        return parsed;
      }
    }
  } catch (e) {
    console.error("Lỗi đọc lời chúc:", e);
  }
  return DEFAULT_WISHES;
}

function renderWishesList(wishes) {
  const container = document.getElementById("wishesList");
  if (!container) return;

  container.innerHTML = wishes.map((item, idx) => {
    const isNewClass = item.isNew ? "is-new" : "";
    return `
      <div class="wish-item ${isNewClass}">
        <div class="wish-meta">
          <span class="wish-author">✨ ${escapeHtml(item.name)}</span>
          <span class="wish-tag">${escapeHtml(item.attending || "Sẽ đến nhaa! 💖")}</span>
        </div>
        <p class="wish-content">“${escapeHtml(item.message)}”</p>
      </div>
    `;
  }).join("");
}

function initWishesBoard() {
  const wishes = getStoredWishes();
  renderWishesList(wishes);
}

function addNewWish(newWish) {
  let wishes = getStoredWishes();
  wishes = [newWish, ...wishes];
  try {
    localStorage.setItem("ngoctu_graduation_wishes", JSON.stringify(wishes));
  } catch (e) {
    console.error("Lỗi lưu lời chúc:", e);
  }
  renderWishesList(wishes);
}

function escapeHtml(str) {
  if (!str) return "";
  return String(str)
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
}

// ================= 4. XỬ LÝ FORM XÁC NHẬN THAM DỰ (RSVP) =================
function initRsvpForm() {
  const rsvpForm = document.getElementById("rsvpForm");
  const radioInputs = document.querySelectorAll('input[name="attending"]');
  const btnSubmit = document.getElementById("btnSubmitRsvp");
  const statusMsg = document.getElementById("rsvpStatusMsg");

  // Radio button visual feedback
  radioInputs.forEach(radio => {
    radio.addEventListener("change", () => {
      document.querySelectorAll(".radio-card").forEach(c => c.classList.remove("is-selected"));
      const parentCard = radio.closest(".radio-card");
      if (parentCard) parentCard.classList.add("is-selected");
    });
  });

  if (!rsvpForm) return;

  rsvpForm.addEventListener("submit", async (e) => {
    e.preventDefault();

    const nameInput = document.getElementById("guestNameInput");
    const name = nameInput ? nameInput.value.trim() : "";

    if (!name) {
      if (statusMsg) {
        statusMsg.hidden = false;
        statusMsg.className = "rsvp-status-msg is-error";
        statusMsg.textContent = "Bạn ơi, hãy nhập tên của bạn nhé! ♡";
      }
      if (nameInput) nameInput.focus();
      return;
    }

    const attendingInput = document.querySelector('input[name="attending"]:checked');
    const attendingVal = attendingInput ? attendingInput.value : "yes";
    const attendingText = attendingVal === "yes" ? "Sẽ đến nhaa! 💖" : "Tiếc quá, bận rồi 🥺";

    const msgInput = document.getElementById("guestMsgInput");
    const message = msgInput ? msgInput.value.trim() : "";

    const userWishText = message || "Hẹn gặp Ngọc Tú vào ngày tốt nghiệp 28.11 nhé! 🎓✨";

    // 1. Lưu và cập nhật vào Sổ lưu bút ngay lập tức
    addNewWish({
      name: name,
      attending: attendingText,
      message: userWishText,
      time: "Vừa xong",
      isNew: true
    });

    if (btnSubmit) {
      btnSubmit.disabled = true;
      btnSubmit.innerHTML = '<span>Đang gửi xác nhận... ⏳</span>';
    }
    if (statusMsg) {
      statusMsg.hidden = false;
      statusMsg.className = "rsvp-status-msg is-success";
      statusMsg.innerHTML = `Cảm ơn <strong>${escapeHtml(name)}</strong> thật nhiều! Đang mở trang lời chúc... ♡`;
    }

    // 2. Gửi ngầm về Email FormSubmit
    fetch("https://formsubmit.co/ajax/ngoctung2188@gmail.com", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: JSON.stringify({
        _subject: `[RSVP Tốt Nghiệp] ${name} vừa gửi xác nhận tham dự!`,
        "Tên khách mời": name,
        "Tham dự lễ": attendingText,
        "Lời chúc gửi Tú": userWishText
      })
    }).catch(err => {
      console.warn("Gửi email background:", err);
    });

    // 3. Tự động chuyển lật sang Slide 6 (Hẹn gặp người thương - 28/11/2026)
    setTimeout(() => {
      if (btnSubmit) {
        btnSubmit.disabled = false;
        btnSubmit.innerHTML = '<span>Gửi xác nhận cho Tú 💌</span>';
      }
      if (flipToPageFn) {
        flipToPageFn(6);
      }
    }, 700);
  });
}
'@

[System.IO.File]::WriteAllText("$PSScriptRoot\..\script.js", $newJs, [System.Text.Encoding]::UTF8)
Write-Host "script.js updated successfully!"
