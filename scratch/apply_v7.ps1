# apply_v7.ps1
$ErrorActionPreference = "Stop"

# -------------------------------------------------------------
# 1. Update index.html
# -------------------------------------------------------------
$html = Get-Content -Path "index.html" -Raw -Encoding UTF8

# 1.1 In Page 5 form: add the public/private wish checkbox
$targetTextareaGroup = @"
              <div class="form-group">
                <label class="form-label" for="guestMsgInput">Lời chúc hoặc nhắn gửi cho Tú:</label>
                <textarea id="guestMsgInput" name="message" class="form-textarea" rows="3" placeholder="Gửi lời thương thương đến Ngọc Tú nha..."></textarea>
              </div>
"@

$replaceTextareaGroup = @"
              <div class="form-group">
                <label class="form-label" for="guestMsgInput">Lời chúc hoặc nhắn gửi cho Tú:</label>
                <textarea id="guestMsgInput" name="message" class="form-textarea" rows="3" placeholder="Gửi lời thương thương đến Ngọc Tú nha..."></textarea>
              </div>

              <!-- Tùy chọn cho phép hiển thị lên Sổ lưu bút (mặc định đã chọn) -->
              <div class="form-group checkbox-opt-group">
                <label class="custom-checkbox-label">
                  <input type="checkbox" id="publicWishCheckbox" name="isPublic" checked>
                  <span class="custom-checkbox-ui"></span>
                  <span class="custom-checkbox-text">Hiển thị lời chúc này lên Sổ lưu bút 🌸</span>
                </label>
              </div>
"@

if ($html.Contains($targetTextareaGroup)) {
  $html = $html.Replace($targetTextareaGroup, $replaceTextareaGroup)
  Write-Host "Added public wish checkbox to Page 5 form"
} else {
  Write-Host "Target textarea group not found, check index.html structure" -ForegroundColor Yellow
}

# 1.2 In Page 6: remove "DẤU MỐC THANH XUÂN", update title & subtitle, wrap wishes in viewport
$targetPage6Header = @"
          <header class="farewell-header">
            <div class="farewell-badge">
              <span>🌸 DẤU MỐC THANH XUÂN</span>
            </div>
            <h2 class="farewell-main-title">Hẹn gặp người thương</h2>
            <p class="farewell-date">28/11/2026</p>
            <p class="farewell-sub-text">
              Cảm ơn bạn đã luôn là một phần thật đẹp trong thanh xuân của Tú ♡
            </p>
          </header>
"@

$replacePage6Header = @"
          <header class="farewell-header">
            <h2 class="farewell-main-title">Hẹn gặp người thương</h2>
            <p class="farewell-date">28/11/2026</p>
            <p class="farewell-sub-text">
              Cảm ơn bạn đã luôn là một phần thật đẹp<br>
              trong thanh xuân của Ngọc Tú ♡
            </p>
          </header>
"@

if ($html.Contains($targetPage6Header)) {
  $html = $html.Replace($targetPage6Header, $replacePage6Header)
  Write-Host "Updated Page 6 header (removed badge, updated Ngọc Tú, broken into 2 lines)"
} else {
  Write-Host "Target Page 6 header not found directly, trying regex" -ForegroundColor Yellow
  $headerRegex = '(?s)<header class="farewell-header">[\s\S]*?</header>'
  $html = [System.Text.RegularExpressions.Regex]::Replace($html, $headerRegex, $replacePage6Header.Trim())
}

# 1.3 In Page 6 wishes board: wrap wishesList in wishes-marquee-viewport
$targetWishesCard = @"
          <div class="wishes-board-card">
            <div class="wishes-board-header">
              <span class="wishes-icon">💌</span>
              <span class="wishes-title">Lời chúc từ những người thương</span>
            </div>
            <div class="wishes-list" id="wishesList">
              <!-- Render động từ JavaScript -->
            </div>
          </div>
"@

$replaceWishesCard = @"
          <div class="wishes-board-card">
            <div class="wishes-board-header">
              <span class="wishes-icon">💌</span>
              <span class="wishes-title">Lời chúc từ những người thương</span>
            </div>
            <div class="wishes-marquee-viewport" id="wishesViewport">
              <div class="wishes-list" id="wishesList">
                <!-- Render động từ JavaScript -->
              </div>
            </div>
          </div>
"@

if ($html.Contains($targetWishesCard)) {
  $html = $html.Replace($targetWishesCard, $replaceWishesCard)
  Write-Host "Wrapped wishesList in wishes-marquee-viewport"
}

[System.IO.File]::WriteAllText("$PSScriptRoot\..\index.html", $html, [System.Text.Encoding]::UTF8)
Write-Host "Updated index.html successfully!"

# -------------------------------------------------------------
# 2. Update style.css
# -------------------------------------------------------------
$css = Get-Content -Path "style.css" -Raw -Encoding UTF8

# Replace farewell header styles and add checkbox + vertical marquee styles
$farewellSectionRegex = '(?s)/\* =+\s*12\.\s*TRANG 6:\s*HẸN GẶP NGƯỜI THƯƠNG[\s\S]*$'

$newFarewellCss = @"
/* ================= 12. TRANG 6: HẸN GẶP NGƯỜI THƯƠNG & SỔ LƯU BÚT ================= */
.checkbox-opt-group {
  margin-top: -2px;
  margin-bottom: 2px;
}

.custom-checkbox-label {
  display: flex;
  align-items: center;
  gap: 9px;
  cursor: pointer;
  user-select: none;
}

.custom-checkbox-label input[type="checkbox"] {
  position: absolute;
  opacity: 0;
  pointer-events: none;
}

.custom-checkbox-ui {
  width: 18px;
  height: 18px;
  border-radius: 5px;
  border: 1.5px solid rgba(232, 39, 94, 0.4);
  background: #FFF9FB;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  transition: all 0.2s ease;
}

.custom-checkbox-label input[type="checkbox"]:checked + .custom-checkbox-ui {
  background: var(--pink-accent);
  border-color: var(--pink-accent);
}

.custom-checkbox-label input[type="checkbox"]:checked + .custom-checkbox-ui::after {
  content: "✔";
  color: #FFFFFF;
  font-size: 11px;
  font-weight: 700;
  line-height: 1;
}

.custom-checkbox-text {
  font-family: var(--font-editorial);
  font-size: clamp(12px, 3.2vw, 13px);
  color: #3C2A31;
  font-weight: 500;
}

.farewell-header {
  margin-bottom: 12px;
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 3px;
}

.farewell-main-title {
  font-family: var(--font-editorial);
  font-size: clamp(15.5px, 3.8vw, 17.5px);
  font-weight: 500;
  color: var(--pink-accent);
  letter-spacing: 0.06em;
  margin: 0;
  line-height: 1.35;
  text-transform: uppercase;
}

.farewell-date {
  font-family: var(--font-editorial);
  font-size: clamp(13.5px, 3.4vw, 15px);
  font-weight: 500;
  color: #5A4A52;
  letter-spacing: 0.08em;
  margin: 0 0 6px 0;
}

.farewell-sub-text {
  font-family: var(--font-editorial);
  font-size: clamp(12.5px, 3.3vw, 13.5px);
  font-weight: 400;
  color: var(--text-muted);
  margin: 0 auto;
  line-height: 1.6;
  text-align: center;
}

.wishes-board-card {
  background: #FFFFFF;
  border-radius: 14px;
  padding: 13px 12px;
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
  font-size: 13px;
  font-weight: 700;
  color: #B51E4E;
  border-bottom: 1px dashed rgba(232, 39, 94, 0.2);
  padding-bottom: 8px;
  margin-bottom: 10px;
}

.wishes-board-header .wishes-icon {
  font-size: 14px;
}

.wishes-board-header .wishes-title {
  letter-spacing: 0.02em;
}

/* KHUNG CHIẾU LỜI CHÚC TỰ ĐỘNG CHẠY DỌC (VERTICAL MARQUEE) */
.wishes-marquee-viewport {
  height: 200px;
  max-height: 200px;
  overflow: hidden;
  position: relative;
  mask-image: linear-gradient(180deg, transparent 0%, #000 6%, #000 94%, transparent 100%);
  -webkit-mask-image: linear-gradient(180deg, transparent 0%, #000 6%, #000 94%, transparent 100%);
}

.wishes-list {
  display: flex;
  flex-direction: column;
  gap: 9px;
  width: 100%;
}

.wishes-list.is-scrolling {
  animation: scrollWishesVertical 18s linear infinite;
  will-change: transform;
}

.wishes-list.is-scrolling:hover,
.wishes-list.is-scrolling:active {
  animation-play-state: paused;
}

@keyframes scrollWishesVertical {
  0% { transform: translateY(0); }
  100% { transform: translateY(-50%); }
}

.wish-item {
  background: #FFF9FB;
  border: 1px solid rgba(232, 39, 94, 0.14);
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

.wishes-empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  height: 160px;
  gap: 8px;
  color: var(--text-muted);
  padding: 16px;
}

.wishes-empty-state .empty-icon {
  font-size: 26px;
  opacity: 0.85;
}

.wishes-empty-state .empty-text {
  font-family: var(--font-editorial);
  font-size: 13px;
  line-height: 1.55;
  margin: 0;
}
"@

$css = [System.Text.RegularExpressions.Regex]::Replace($css, $farewellSectionRegex, $newFarewellCss)
[System.IO.File]::WriteAllText("$PSScriptRoot\..\style.css", $css, [System.Text.Encoding]::UTF8)
Write-Host "Updated style.css successfully!"

# -------------------------------------------------------------
# 3. Update script.js
# -------------------------------------------------------------
$newJs = @'
/**
 * NGỌC TÚ – GRADUATION INVITATION 2026
 * 1. Multi-page 3D Mobile Book Flip (Page 1 -> 6)
 * 2. Cảm ứng vuốt tay (Touch Swipe Left/Right) & nút điều hướng lật trang
 * 3. Chạm vào bìa để lật trang
 * 4. Cá nhân hóa lời nhắn khách mời (?to=Nhi, ?to=Khánh...)
 * 5. Sổ lưu bút tự động cuộn dọc (Vertical Marquee)
 * 6. Bộ lọc ảo nội dung tiêu cực / thô tục & tùy chọn ẩn/hiện lời chúc
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

// Không có lời chúc mẫu ban đầu (xóa hết theo yêu cầu của Tú)
const DEFAULT_WISHES = [];

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

  const page1Card = document.querySelector("#page1 .page-card-dashed");
  if (page1Card) {
    page1Card.addEventListener("click", (e) => {
      if (currentPage === 1 && !e.target.closest("button") && !e.target.closest("a")) {
        flipToPage(2);
      }
    });
  }

  window.addEventListener("keydown", (e) => {
    if (e.key === "ArrowRight" || e.key === "PageDown") {
      flipToPage(currentPage + 1);
    } else if (e.key === "ArrowLeft" || e.key === "PageUp") {
      flipToPage(currentPage - 1);
    }
  });

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

// ================= 3. BỘ LỌC ẢO NỘI DUNG TIÊU CỰC / THÔ TỤC =================
function isContentInappropriate(text) {
  if (!text) return false;
  const raw = text.toLowerCase();
  const normalized = raw
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/[đĐ]/g, "d");

  const toxicPatterns = [
    /\b(dm|dcm|đm|đcm|vcl|vkl|vl|cl|cc|clm|đụ|địt|dit|lồn|lon|cặc|cac|buồi|buoi|dái|dai|đéo|deo)\b/i,
    /\b(chó|cho|súc vật|suc vat|khốn nạn|khon nan|óc chó|oc cho)\b/i,
    /\b(đồ ngu|ngu ngốc|ngu dốt|thằng ngu|con ngu|đần|dan don|hãm|ham lol|ham lon)\b/i,
    /\b(cút|cut di|thần kinh|than kinh|rác rưởi|rac ruoi|xấu xí|chết đi|chet)\b/i,
    /\b(fuck|shit|bitch|asshole|cunt|dick|pussy|idiot|stupid)\b/i
  ];

  for (const pattern of toxicPatterns) {
    if (pattern.test(raw) || pattern.test(normalized)) {
      return true;
    }
  }
  return false;
}

// ================= 4. QUẢN LÝ SỔ LƯU BÚT & TỰ ĐỘNG CUỘN DỌC =================
const STORAGE_KEY = "ngoctu_graduation_wishes_v2";

function getStoredWishes() {
  try {
    const raw = localStorage.getItem(STORAGE_KEY);
    if (raw) {
      const parsed = JSON.parse(raw);
      if (Array.isArray(parsed)) {
        return parsed.filter(w => !isContentInappropriate(w.name + " " + w.message));
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

  // Nếu chưa có lời chúc nào: hiển thị ô trống dịu dàng
  if (!wishes || wishes.length === 0) {
    container.classList.remove("is-scrolling");
    container.innerHTML = `
      <div class="wishes-empty-state">
        <span class="empty-icon">💌</span>
        <p class="empty-text">Chưa có lời chúc nào nè.<br>Hãy là người đầu tiên gửi lời chúc đến Ngọc Tú nhé! ♡</p>
      </div>
    `;
    return;
  }

  // Nếu chỉ có 1 lời chúc: hiển thị tĩnh không cần cuộn
  if (wishes.length === 1) {
    container.classList.remove("is-scrolling");
    const item = wishes[0];
    container.innerHTML = `
      <div class="wish-item ${item.isNew ? 'is-new' : ''}">
        <div class="wish-meta">
          <span class="wish-author">✨ ${escapeHtml(item.name)}</span>
          <span class="wish-tag">${escapeHtml(item.attending || "Sẽ đến nhaa! 💖")}</span>
        </div>
        <p class="wish-content">“${escapeHtml(item.message)}”</p>
      </div>
    `;
    return;
  }

  // Nếu có từ 2 lời chúc trở lên: tự động cuộn dọc (Vertical Marquee)
  const itemsHtml = wishes.map((item) => `
    <div class="wish-item ${item.isNew ? 'is-new' : ''}">
      <div class="wish-meta">
        <span class="wish-author">✨ ${escapeHtml(item.name)}</span>
        <span class="wish-tag">${escapeHtml(item.attending || "Sẽ đến nhaa! 💖")}</span>
      </div>
      <p class="wish-content">“${escapeHtml(item.message)}”</p>
    </div>
  `).join("");

  // Bản sao nối tiếp để cuộn dọc liền mạch vô tận
  const dupHtml = wishes.map((item) => `
    <div class="wish-item" aria-hidden="true">
      <div class="wish-meta">
        <span class="wish-author">✨ ${escapeHtml(item.name)}</span>
        <span class="wish-tag">${escapeHtml(item.attending || "Sẽ đến nhaa! 💖")}</span>
      </div>
      <p class="wish-content">“${escapeHtml(item.message)}”</p>
    </div>
  `).join("");

  container.innerHTML = itemsHtml + dupHtml;
  container.classList.add("is-scrolling");

  // Điều chỉnh tốc độ cuộn mượt mà theo số lượng lời chúc
  const scrollDuration = Math.max(14, wishes.length * 6);
  container.style.animationDuration = `${scrollDuration}s`;
}

function initWishesBoard() {
  const wishes = getStoredWishes();
  renderWishesList(wishes);
}

function addNewWish(newWish) {
  let wishes = getStoredWishes();
  wishes = [newWish, ...wishes];
  try {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(wishes));
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

// ================= 5. XỬ LÝ FORM XÁC NHẬN THAM DỰ (RSVP) =================
function initRsvpForm() {
  const rsvpForm = document.getElementById("rsvpForm");
  const radioInputs = document.querySelectorAll('input[name="attending"]');
  const btnSubmit = document.getElementById("btnSubmitRsvp");
  const statusMsg = document.getElementById("rsvpStatusMsg");

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

    // Kiểm tra checkbox tùy chọn hiển thị công khai lên sổ lưu bút
    const publicCheckbox = document.getElementById("publicWishCheckbox");
    const isPublicWanted = publicCheckbox ? publicCheckbox.checked : true;

    // Kiểm tra bộ lọc nội dung tiêu cực
    const isNegative = isContentInappropriate(name + " " + userWishText);

    // Chỉ hiển thị lên Sổ lưu bút nếu khách đồng ý VÀ nội dung tích cực
    if (isPublicWanted && !isNegative) {
      addNewWish({
        name: name,
        attending: attendingText,
        message: userWishText,
        time: "Vừa xong",
        isNew: true
      });
    }

    if (btnSubmit) {
      btnSubmit.disabled = true;
      btnSubmit.innerHTML = '<span>Đang gửi xác nhận... ⏳</span>';
    }
    if (statusMsg) {
      statusMsg.hidden = false;
      statusMsg.className = "rsvp-status-msg is-success";
      statusMsg.innerHTML = `Cảm ơn <strong>${escapeHtml(name)}</strong> thật nhiều! Đang mở trang lời chúc... ♡`;
    }

    // Gửi email về hộp thư riêng của Ngọc Tú (FormSubmit)
    let emailStatusNote = isPublicWanted ? "[Hiển thị công khai]" : "[Khách chọn gửi riêng tư, không hiện lên web]";
    if (isNegative) {
      emailStatusNote = "[Bị bộ lọc chặn hiển thị trên web do chứa từ nhạy cảm]";
    }

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
        "Lời chúc gửi Tú": userWishText,
        "Trạng thái hiển thị": emailStatusNote
      })
    }).catch(err => {
      console.warn("Gửi email background:", err);
    });

    // Tự động chuyển lật sang Slide 6 (Hẹn gặp người thương - 28/11/2026)
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
Write-Host "Updated script.js successfully!"
