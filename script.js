/**
 * NGỌC TÚ – GRADUATION INVITATION 2026
 * 1. Multi-page 3D Mobile Book Flip (Page 1: Bìa -> Page 2: Dải phim -> Page 3: Thư mời -> Page 4: Chi tiết)
 * 2. Cảm ứng vuốt tay (Touch Swipe Left/Right) & nút điều hướng lật trang tối ưu 100% trên điện thoại
 * 3. Cá nhân hóa lời nhắn cho khách mời (?to=Nhi, ?to=Khánh, ?to=Trang...)
 * 4. Nhạc nền web tự động phát (Bài hát: "Cảm Ơn Người Đã Thức Cùng Tôi" - Phùng Khánh Linh) & Nút bật/tắt âm thanh tinh tế
 */

// ================= DỮ LIỆU CÁ NHÂN HÓA KHÁCH MỜI =================
const GUEST_DATA = {
  "Nhi": {
    salutation: "Gửi Nhi thương mến,",
    message: "Cảm ơn Nhi vì đã luôn ở bên cạnh, lắng nghe và chia sẻ cùng Tú qua từng giai đoạn của thời sinh viên. Những buổi chuyện trò, những khoảnh khắc vui buồn có Nhi đồng hành đã làm cho những năm tháng thanh xuân của Tú trở nên trọn vẹn và đáng nhớ hơn bao giờ hết.\n\nSáng Thứ 7 ngày 28.11 này, Tú rất mong có Nhi ở bên cạnh để cùng Tú ghi lại dấu mốc quan trọng này nhé! ❤️"
  },
  "Khánh": {
    salutation: "Gửi Khánh thương mến,",
    message: "Bốn năm đại học trôi qua thật nhanh với biết bao kỷ niệm và thử thách. Cảm ơn Khánh vì đã luôn là một người bạn tuyệt vời, luôn đồng hành và tiếp thêm năng lượng tích cực cho Tú trong suốt chặng đường vừa qua.\n\nNgày tốt nghiệp này sẽ thật thiếu trọn vẹn nếu không có Khánh. Hẹn gặp Khánh vào sáng Thứ 7 ngày 28.11 nhé, tụi mình nhất định phải chụp thật nhiều ảnh đẹp cùng nhau nha!"
  },
  "Phát": {
    salutation: "Gửi Phát thương mến,",
    message: "Nhìn lại chặng đường 4 năm đại học đã qua, Tú thật sự biết ơn vì luôn có Phát đồng hành và ủng hộ. Cảm ơn những lần hỗ trợ nhiệt tình, những cuộc trò chuyện và sự chân thành mà Phát đã dành cho Tú.\n\nCột mốc tốt nghiệp này là một kỷ niệm vô cùng ý nghĩa của thanh xuân. Tú rất mong được đón Phát đến chung vui và chụp cùng Tú những tấm hình thật đẹp vào ngày 28.11 này nha!"
  },
  "Trang": {
    salutation: "Gửi Trang yêu quý,",
    message: "Cảm ơn Trang vì đã là một phần thật dịu dàng và ấm áp trong những năm tháng đại học của Tú. Cảm ơn những sẻ chia, những nụ cười và sự thấu hiểu mà Trang luôn dành cho Tú suốt thời gian qua.\n\nNgày 28.11 là ngày Tú chính thức khép lại một chương rực rỡ và mở ra hành trình mới. Hãy đến chung vui và lưu lại những khoảnh khắc đáng nhớ nhất cùng Tú nha Trang ơi! ♡"
  },
  "Duy": {
    salutation: "Gửi Duy thương mến,",
    message: "Thấm thoát mà 4 năm đại học đã đến đích rồi. Cảm ơn Duy vì đã luôn ở đó, luôn là người bạn đồng hành đáng tin cậy và chia sẻ cùng Tú qua từng mùa thi, từng bài thuyết trình và những deadline căng thẳng.\n\nNgày 28.11 này là một dấu mốc rất đặc biệt đối với Tú. Tú rất mong Duy sẽ có mặt để cùng Tú ăn mừng và lưu lại những khoảnh khắc thanh xuân thật đáng nhớ này nhé!"
  },
  "Thuận": {
    salutation: "Gửi Thuận thương mến,",
    message: "Cảm ơn Thuận vì đã luôn đồng hành, giúp đỡ và mang lại thật nhiều niềm vui trong suốt những năm tháng thanh xuân vừa qua của Tú. Nhờ có những người bạn như Thuận mà chặng đường đại học của Tú đã trở nên vô cùng ý nghĩa và nhiều màu sắc.\n\nSáng ngày 28.11 này, Tú rất vui và hạnh phúc nếu được đón Thuận đến cùng chung vui và chụp thật nhiều bức hình kỷ niệm nha!"
  }
};

// ================= KHỞI TẠO DOM CONTENT LOADED =================
document.addEventListener("DOMContentLoaded", () => {
  initPersonalizedGreeting();
  initMobileBookFlip();
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
  }
}

// ================= 2. HỆ THỐNG LẬT SÁCH 3D ĐA TRANG CHO ĐIỆN THOẠI =================
let currentPage = 1;
let isFlipping = false;

function initMobileBookFlip() {
  const bookViewport = document.getElementById("bookViewport");

  function flipToPage(targetPage) {
    if (isFlipping || targetPage === currentPage || targetPage < 1 || targetPage > 4 || !bookViewport) return;
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
      const target = parseInt(btn.getAttribute("data-flip-target"), 10);
      if (!isNaN(target)) {
        flipToPage(target);
      }
    });
  });

  // 2. Phím mũi tên bàn phím (Left / Right)
  window.addEventListener("keydown", (e) => {
    if (e.key === "ArrowRight" || e.key === "PageDown") {
      flipToPage(currentPage + 1);
    } else if (e.key === "ArrowLeft" || e.key === "PageUp") {
      flipToPage(currentPage - 1);
    }
  });

  // 3. CẢM ỨNG VUỐT TAY (TOUCH SWIPE) TRÊN ĐIỆN THOẠI
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
