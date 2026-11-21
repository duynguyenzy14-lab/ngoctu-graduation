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