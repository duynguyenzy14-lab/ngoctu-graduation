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
    message: "Cảm ơn Nhi vì đã luôn ở bên cạnh, lắng nghe và chia sẻ cùng Tú qua từng giai đoạn của thời sinh viên. Những buổi chuyện trò, những khoảnh khắc vui buồn có Nhi đồng hành đã làm cho những năm tháng thanh xuân của Tú trở nên trọn vẹn và đáng nhớ hơn bao giờ hết.\n\nSáng Thứ Bảy, ngày 28.11, mình sẽ chính thức khép lại hành trình 4 năm tại OU. Ngọc Tú rất mong được gặp mọi người, cùng chung vui và lưu lại thật nhiều khoảnh khắc đáng nhớ ♡"
  },
  "Khánh": {
    salutation: "Gửi Khánh thương mến,",
    message: "Bốn năm đại học trôi qua thật nhanh với biết bao kỷ niệm và thử thách. Cảm ơn Khánh vì đã luôn là một người bạn tuyệt vời, luôn đồng hành và tiếp thêm năng lượng tích cực cho Tú trong suốt chặng đường vừa qua.\n\nSáng Thứ Bảy, ngày 28.11, mình sẽ chính thức khép lại hành trình 4 năm tại OU. Ngọc Tú rất mong được gặp mọi người, cùng chung vui và lưu lại thật nhiều khoảnh khắc đáng nhớ ♡"
  },
  "Phát": {
    salutation: "Gửi Phát thương mến,",
    message: "Nhìn lại chặng đường 4 năm đại học đã qua, Tú thật sự biết ơn vì luôn có Phát đồng hành và ủng hộ. Cảm ơn những lần hỗ trợ nhiệt tình, những cuộc trò chuyện và sự chân thành mà Phát đã dành cho Tú.\n\nSáng Thứ Bảy, ngày 28.11, mình sẽ chính thức khép lại hành trình 4 năm tại OU. Ngọc Tú rất mong được gặp mọi người, cùng chung vui và lưu lại thật nhiều khoảnh khắc đáng nhớ ♡"
  },
  "Trang": {
    salutation: "Gửi Trang yêu quý,",
    message: "Cảm ơn Trang vì đã là một phần thật dịu dàng và ấm áp trong những năm tháng đại học của Tú. Cảm ơn những sẻ chia, những nụ cười và sự thấu hiểu mà Trang luôn dành cho Tú suốt thời gian qua.\n\nSáng Thứ Bảy, ngày 28.11, mình sẽ chính thức khép lại hành trình 4 năm tại OU. Ngọc Tú rất mong được gặp mọi người, cùng chung vui và lưu lại thật nhiều khoảnh khắc đáng nhớ ♡"
  },
  "Duy": {
    salutation: "Gửi Duy thương mến,",
    message: "Thấm thoát mà 4 năm đại học đã đến đích rồi. Cảm ơn Duy vì đã luôn ở đó, luôn là người bạn đồng hành đáng tin cậy và chia sẻ cùng Tú qua từng mùa thi, từng bài thuyết trình và những deadline căng thẳng.\n\nSáng Thứ Bảy, ngày 28.11, mình sẽ chính thức khép lại hành trình 4 năm tại OU. Ngọc Tú rất mong được gặp mọi người, cùng chung vui và lưu lại thật nhiều khoảnh khắc đáng nhớ ♡"
  },
  "Thuận": {
    salutation: "Gửi Thuận thương mến,",
    message: "Cảm ơn Thuận vì đã luôn đồng hành, giúp đỡ và mang lại thật nhiều niềm vui trong suốt những năm tháng thanh xuân vừa qua của Tú. Nhờ có những người bạn như Thuận mà chặng đường đại học của Tú đã trở nên vô cùng ý nghĩa và nhiều màu sắc.\n\nSáng Thứ Bảy, ngày 28.11, mình sẽ chính thức khép lại hành trình 4 năm tại OU. Ngọc Tú rất mong được gặp mọi người, cùng chung vui và lưu lại thật nhiều khoảnh khắc đáng nhớ ♡"
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

  // 4. CẢM ỨNG VUỐT TAY (SWIPE) TRÊN ĐIỆN THOẠI
  let touchStartX = 0;
  let touchStartY = 0;
  let touchEndX = 0;
  let touchEndY = 0;
  let touchMoved = false;

  window.addEventListener("touchstart", (e) => {
    touchMoved = false;
    if (e.touches && e.touches.length > 0) {
      touchStartX = e.touches[0].clientX;
      touchStartY = e.touches[0].clientY;
    }
  }, { passive: true });

  window.addEventListener("touchmove", () => {
    touchMoved = true;
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

  // 5. CHẠM VÀO NỬA TRÁI / PHẢI MÀN HÌNH ĐỂ LẬT TRANG (TAP LEFT TO PREV / TAP RIGHT TO NEXT)
  window.addEventListener("click", (e) => {
    // Không lật trang nếu đang thao tác trên form, nút bấm, link hoặc ô nhập liệu
    if (e.target.closest("input, textarea, button, a, label, select, .film-strip-card, .wishes-list")) {
      return;
    }

    // Bỏ qua nếu vừa thực hiện thao tác vuốt tay (drag / swipe)
    if (touchMoved) {
      touchMoved = false;
      return;
    }

    const clickX = e.clientX;
    const screenWidth = window.innerWidth;

    if (clickX >= screenWidth / 2) {
      // Chạm nửa màn hình bên phải -> Lật sang trang tiếp theo
      flipToPage(currentPage + 1);
    } else {
      // Chạm nửa màn hình bên trái -> Lật ngược lại trang trước
      flipToPage(currentPage - 1);
    }
  });
}

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

// ================= 4. QUẢN LÝ SỔ LƯU BÚT ĐỒNG BỘ ĐÁM MÂY (CLOUD SYNC) & TỰ ĐỘNG CUỘN DỌC =================
const STORAGE_KEY = "ngoctu_graduation_wishes_v2";
const CLOUD_GUESTBOOK_API = "https://api.restful-api.dev/objects/ff808181a09d98f701a1fe4fe584112c";

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

async function fetchCloudWishes() {
  try {
    const res = await fetch(CLOUD_GUESTBOOK_API);
    if (res.ok) {
      const data = await res.json();
      if (data && data.data && Array.isArray(data.data.wishes)) {
        const cloudWishes = data.data.wishes.filter(w => !isContentInappropriate(w.name + " " + w.message));
        localStorage.setItem(STORAGE_KEY, JSON.stringify(cloudWishes));
        renderWishesList(cloudWishes);
      }
    }
  } catch (err) {
    console.warn("Không thể tải lời chúc từ đám mây (dùng cache local):", err);
  }
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
          <span class="wish-tag">${escapeHtml(item.attending || "Sẽ đến nhaa!")}</span>
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
        <span class="wish-tag">${escapeHtml(item.attending || "Sẽ đến nhaa!")}</span>
      </div>
      <p class="wish-content">“${escapeHtml(item.message)}”</p>
    </div>
  `).join("");

  // Bản sao nối tiếp để cuộn dọc liền mạch vô tận
  const dupHtml = wishes.map((item) => `
    <div class="wish-item" aria-hidden="true">
      <div class="wish-meta">
        <span class="wish-author">✨ ${escapeHtml(item.name)}</span>
        <span class="wish-tag">${escapeHtml(item.attending || "Sẽ đến nhaa!")}</span>
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
  // 1. Hiển thị tức thì từ cache cục bộ (zero lag)
  const wishes = getStoredWishes();
  renderWishesList(wishes);

  // 2. Tự động đồng bộ từ Đám mây để ai mở link cũng thấy
  fetchCloudWishes();
}

async function addNewWish(newWish) {
  // 1. Hiển thị ngay lên màn hình cho người gửi
  let wishes = getStoredWishes();
  wishes = [newWish, ...wishes];
  try {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(wishes));
  } catch (e) {
    console.error("Lỗi lưu lời chúc:", e);
  }
  renderWishesList(wishes);

  // 2. Gửi đồng bộ lên Đám mây công khai để TẤT CẢ mọi người mở link đều thấy
  try {
    const res = await fetch(CLOUD_GUESTBOOK_API);
    if (res.ok) {
      const currentObj = await res.json();
      const currentWishes = (currentObj.data && Array.isArray(currentObj.data.wishes)) ? currentObj.data.wishes : [];
      const cleanWish = {
        name: newWish.name,
        attending: newWish.attending,
        message: newWish.message,
        time: "Vừa xong"
      };
      const updatedList = [cleanWish, ...currentWishes.filter(w => !isContentInappropriate(w.name + " " + w.message))];
      await fetch(CLOUD_GUESTBOOK_API, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          name: "Ngoctu Graduation Guestbook 2026",
          data: { wishes: updatedList }
        })
      });
    }
  } catch (cloudErr) {
    console.warn("Lỗi đồng bộ đám mây:", cloudErr);
  }
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
    const attendingText = attendingVal === "yes" ? "Sẽ đến nhaa!" : "Tiếc quá, bận rồi";

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