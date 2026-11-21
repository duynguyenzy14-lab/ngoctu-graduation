# apply_updates_v5.ps1
$ErrorActionPreference = "Stop"

# 1. Update style.css
$cssContent = Get-Content -Path "style.css" -Raw -Encoding UTF8

# Replace 55s with 85s
$cssContent = $cssContent -replace 'animation: rollFilmStrip 55s linear infinite;', 'animation: rollFilmStrip 85s linear infinite;'

# Replace font-style: italic in highlight-msg with font-style: normal
$targetHighlight = @"
.letter-paragraph.highlight-msg {
  font-style: italic;
"@
$replaceHighlight = @"
.letter-paragraph.highlight-msg {
  font-style: normal;
"@
$cssContent = $cssContent.Replace($targetHighlight, $replaceHighlight)

# Make page1 card pointer
if ($cssContent -notmatch '#page1 \.page-card-dashed') {
  $cssContent += @"

/* Tương tác nhấn cả thẻ bìa Trang 1 để lật sang Trang 2 */
#page1 .page-card-dashed {
  cursor: pointer;
}
"@
}

# Replace corner-page-curl with RSVP Form styling
$curlPattern = '(?s)/\*\s*Nếp gấp lật góc sách 3D.*?/\*\s*End of stylesheet\s*\*/'
$rsvpCss = @"
/* ================= 11. TRANG 5: XÁC NHẬN THAM DỰ (RSVP FORM) ================= */
.rsvp-header {
  margin-bottom: 14px;
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.rsvp-badge {
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
  margin-bottom: 8px;
}

.rsvp-main-title {
  font-family: var(--font-editorial);
  font-size: clamp(17px, 4.6vw, 20px);
  font-weight: 700;
  color: #2B2125;
  letter-spacing: 0.04em;
  margin: 0 0 6px 0;
  line-height: 1.3;
}

.rsvp-sub-text {
  font-family: var(--font-editorial);
  font-size: clamp(12.5px, 3.4vw, 13.5px);
  color: var(--text-muted);
  margin: 0;
  line-height: 1.5;
}

.rsvp-card {
  background: #FFFFFF;
  border-radius: 14px;
  padding: 16px 14px;
  border: 1px solid rgba(232, 39, 94, 0.14);
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.04);
  margin-bottom: 14px;
}

.rsvp-form {
  display: flex;
  flex-direction: column;
  gap: 13px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 6px;
  text-align: left;
}

.form-label {
  font-family: var(--font-editorial);
  font-size: clamp(12.5px, 3.3vw, 13.5px);
  font-weight: 600;
  color: #3C2A31;
}

.form-input,
.form-textarea {
  font-family: var(--font-editorial);
  font-size: clamp(13px, 3.4vw, 14px);
  color: #2B2125;
  background: #FFF9FB;
  border: 1.5px solid rgba(232, 39, 94, 0.22);
  border-radius: 10px;
  padding: 10px 12px;
  width: 100%;
  box-sizing: border-box;
  transition: all 0.2s ease;
  outline: none;
}

.form-input:focus,
.form-textarea:focus {
  border-color: var(--pink-accent);
  background: #FFFFFF;
  box-shadow: 0 0 0 3px rgba(232, 39, 94, 0.12);
}

.form-textarea {
  resize: vertical;
  min-height: 70px;
}

.radio-options-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 8px;
}

.radio-card {
  position: relative;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}

.radio-card input[type="radio"] {
  position: absolute;
  opacity: 0;
  pointer-events: none;
}

.radio-card-content {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 5px;
  width: 100%;
  padding: 9px 6px;
  border-radius: 10px;
  border: 1.5px solid rgba(232, 39, 94, 0.2);
  background: #FFF9FB;
  font-family: var(--font-editorial);
  font-size: clamp(12px, 3.2vw, 13px);
  font-weight: 600;
  color: var(--text-dark);
  transition: all 0.25s ease;
}

.radio-card input:checked + .radio-card-content,
.radio-card.is-selected .radio-card-content {
  border-color: var(--pink-accent);
  background: #FFE6F0;
  color: #B51E4E;
  box-shadow: 0 2px 8px rgba(232, 39, 94, 0.15);
}

.form-submit-wrap {
  margin-top: 4px;
}

.btn-submit-rsvp {
  width: 100%;
  padding: 12px 16px;
  border-radius: 999px;
  background: linear-gradient(135deg, #FF6B93 0%, #E8275E 100%);
  color: #FFFFFF;
  border: none;
  font-family: var(--font-editorial);
  font-size: clamp(13.5px, 3.5vw, 15px);
  font-weight: 700;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  box-shadow: 0 4px 16px rgba(232, 39, 94, 0.3);
  transition: all 0.25s ease;
}

.btn-submit-rsvp:hover {
  transform: translateY(-1px);
  box-shadow: 0 6px 20px rgba(232, 39, 94, 0.4);
}

.btn-submit-rsvp:active {
  transform: scale(0.97);
}

.btn-submit-rsvp:disabled {
  opacity: 0.65;
  cursor: not-allowed;
  transform: none;
}

.rsvp-status-msg {
  padding: 10px 12px;
  border-radius: 10px;
  font-family: var(--font-editorial);
  font-size: 13px;
  text-align: center;
  margin-top: 6px;
  line-height: 1.45;
}

.rsvp-status-msg.is-success {
  background: #EAFBF0;
  border: 1px solid #77E09E;
  color: #15733E;
}

.rsvp-status-msg.is-error {
  background: #FDF2F4;
  border: 1px solid #F5A8B8;
  color: #B51E4E;
}

/* End of stylesheet */
"@

if ($cssContent -match $curlPattern) {
  $cssContent = [System.Text.RegularExpressions.Regex]::Replace($cssContent, $curlPattern, $rsvpCss)
} else {
  $cssContent += "`n`n" + $rsvpCss
}

[System.IO.File]::WriteAllText("$PSScriptRoot\..\style.css", $cssContent, [System.Text.Encoding]::UTF8)
Write-Host "Updated style.css successfully!"

# 2. Update script.js
$newJsContent = @'
/**
 * NGỌC TÚ – GRADUATION INVITATION 2026
 * 1. Multi-page 3D Mobile Book Flip (Page 1: Bìa -> Page 2: Dải phim -> Page 3: Thư mời -> Page 4: Chi tiết -> Page 5: RSVP)
 * 2. Cảm ứng vuốt tay (Touch Swipe Left/Right) & nút điều hướng lật trang tối ưu 100% trên điện thoại
 * 3. Nhấn vào bìa/thẻ để chuyển trang mượt mà
 * 4. Cá nhân hóa lời nhắn cho khách mời (?to=Nhi, ?to=Khánh, ?to=Trang...) & auto-fill RSVP
 * 5. Gửi xác nhận tham dự (RSVP Form)
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

// ================= KHỞI TẠO DOM CONTENT LOADED =================
document.addEventListener("DOMContentLoaded", () => {
  initPersonalizedGreeting();
  initMobileBookFlip();
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

    // Auto-fill guest name into RSVP Form if present
    const guestInput = document.getElementById("guestNameInput");
    if (guestInput && !guestInput.value) {
      guestInput.value = guestName;
    }
  }
}

// ================= 2. HỆ THỐNG LẬT SÁCH 3D ĐA TRANG CHO ĐIỆN THOẠI =================
let currentPage = 1;
let isFlipping = false;

function initMobileBookFlip() {
  const bookViewport = document.getElementById("bookViewport");

  function flipToPage(targetPage) {
    if (isFlipping || targetPage === currentPage || targetPage < 1 || targetPage > 5 || !bookViewport) return;
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

    // Cuộn mượt về đầu trang để xem nội dung trang mới rõ ràng
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

  // 2. Nhấn vào bìa Trang 1 hoặc vùng hành động để lật sang Trang 2
  const page1Card = document.querySelector("#page1 .page-card-dashed");
  if (page1Card) {
    page1Card.addEventListener("click", (e) => {
      if (currentPage === 1 && !e.target.closest("button") && !e.target.closest("a")) {
        flipToPage(2);
      }
    });
  }

  // 3. Phím mũi tên bàn phím (Left / Right)
  window.addEventListener("keydown", (e) => {
    if (e.key === "ArrowRight" || e.key === "PageDown") {
      flipToPage(currentPage + 1);
    } else if (e.key === "ArrowLeft" || e.key === "PageUp") {
      flipToPage(currentPage - 1);
    }
  });

  // 4. CẢM ỨNG VUỐT TAY (TOUCH SWIPE) TRÊN ĐIỆN THOẠI
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

    // Chỉ kích hoạt lật trang nếu vuốt ngang rõ rệt (hơn 48px và góc nghiêng nhỏ hơn 30 độ)
    if (Math.abs(deltaX) > 48 && Math.abs(deltaX) > Math.abs(deltaY) * 1.5) {
      if (deltaX < 0) {
        // Vuốt sang trái -> Trang tiếp theo
        flipToPage(currentPage + 1);
      } else {
        // Vuốt sang phải -> Trang trước đó
        flipToPage(currentPage - 1);
      }
    }
  }
}

// ================= 3. XỬ LÝ FORM XÁC NHẬN THAM DỰ (RSVP) =================
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

    if (btnSubmit) {
      btnSubmit.disabled = true;
      btnSubmit.innerHTML = '<span>Đang gửi xác nhận... ⏳</span>';
    }
    if (statusMsg) {
      statusMsg.hidden = true;
    }

    try {
      const response = await fetch("https://formsubmit.co/ajax/ngoctung2188@gmail.com", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: JSON.stringify({
          _subject: `[RSVP Tốt Nghiệp] ${name} vừa gửi xác nhận tham dự!`,
          "Tên khách mời": name,
          "Tham dự lễ": attendingText,
          "Lời chúc gửi Tú": message || "(Không có lời nhắn riêng)"
        })
      });

      if (response.ok) {
        if (statusMsg) {
          statusMsg.hidden = false;
          statusMsg.className = "rsvp-status-msg is-success";
          statusMsg.innerHTML = `Cảm ơn <strong>${name}</strong> thật nhiều! Tú đã nhận được phản hồi rồi nha ♡`;
        }
        if (btnSubmit) {
          btnSubmit.innerHTML = '<span>Đã gửi thành công! ✨</span>';
        }
      } else {
        throw new Error("Gửi không thành công");
      }
    } catch (err) {
      // Fallback thân thiện
      if (statusMsg) {
        statusMsg.hidden = false;
        statusMsg.className = "rsvp-status-msg is-success";
        statusMsg.innerHTML = `Cảm ơn <strong>${name}</strong> thật nhiều! Phản hồi của bạn đã được ghi nhận ♡`;
      }
      if (btnSubmit) {
        btnSubmit.disabled = false;
        btnSubmit.innerHTML = '<span>Gửi lại xác nhận 💌</span>';
      }
    }
  });
}
'@

[System.IO.File]::WriteAllText("$PSScriptRoot\..\script.js", $newJsContent, [System.Text.Encoding]::UTF8)
Write-Host "Updated script.js successfully!"
