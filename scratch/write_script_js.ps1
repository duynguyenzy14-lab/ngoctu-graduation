$jsContent = @'
/**
 * NGỌC TÚ – GRADUATION INVITATION 2026
 * 1. Multi-page 3D Mobile Book Flip (Page 1: Bìa -> Page 2: Dải phim -> Page 3: Thư mời -> Page 4: Chi tiết)
 * 2. Cảm ứng vuốt tay (Touch Swipe Left/Right) tối ưu 100% trên điện thoại
 * 3. Cá nhân hóa lời nhắn cho khách mời (?to=Nhi, ?to=Khánh, ?to=Trang...)
 * 4. Nhạc nền YouTube tự động phát & tự động mở tiếng khi chạm (Phùng Khánh Linh - Cảm Ơn Người Đã Thức Cùng Tôi)
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
const PAGE_TITLES = {
  1: "Trang 1 / 4 · Bìa kỷ niệm",
  2: "Trang 2 / 4 · Dải phim 35mm",
  3: "Trang 3 / 4 · Thư mời từ Tú",
  4: "Trang 4 / 4 · Chi tiết lễ tốt nghiệp"
};

let currentPage = 1;
let isFlipping = false;

function initMobileBookFlip() {
  const bookViewport = document.getElementById("bookViewport");
  const navDots = document.querySelectorAll(".nav-dot");
  const navPageLabel = document.getElementById("navPageLabel");

  function updateNav(page) {
    navDots.forEach(dot => {
      const dotPage = parseInt(dot.getAttribute("data-page"), 10);
      dot.classList.toggle("is-active", dotPage === page);
    });
    if (navPageLabel && PAGE_TITLES[page]) {
      navPageLabel.textContent = PAGE_TITLES[page];
    }
  }

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
      updateNav(currentPage);
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

  // 2. Lắng nghe thanh chấm điều hướng (Nav Dots)
  navDots.forEach(dot => {
    dot.addEventListener("click", () => {
      const page = parseInt(dot.getAttribute("data-page"), 10);
      if (!isNaN(page)) {
        flipToPage(page);
      }
    });
  });

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

    // Chỉ kích hoạt lật trang nếu vuốt ngang rõ rệt (hơn 45px và góc nghiêng nhỏ hơn 30 độ)
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

// ================= 3. TRÌNH PHÁT NHẠC NỀN YOUTUBE (TỰ ĐỘNG PHÁT & DỰ PHÒNG CỬ CHỈ) =================
// Bài hát: Cảm Ơn Người Đã Thức Cùng Tôi - Phùng Khánh Linh (Video ID: J3IRYx3PzzM)
let ytPlayer = null;
let isAudioPlaying = false;
let userHasInteracted = false;

function hideMusicPrompt() {
  const prompt = document.getElementById("musicPrompt");
  if (prompt) prompt.classList.add("is-hidden");
}

function tryTriggerAudioPlayback() {
  userHasInteracted = true;
  hideMusicPrompt();
  if (ytPlayer && typeof ytPlayer.playVideo === "function") {
    try {
      if (typeof ytPlayer.unMute === "function") ytPlayer.unMute();
      if (typeof ytPlayer.setVolume === "function") ytPlayer.setVolume(100);
      ytPlayer.playVideo();
    } catch (e) {
      console.log("Audio play attempt:", e);
    }
  }
}

// Lắng nghe cử chỉ tương tác sớm ngay từ giây đầu tiên trang web tải
const earlyEvents = ["click", "touchstart", "touchend", "mousedown", "pointerdown", "scroll", "keydown"];
function onEarlyGesture() {
  tryTriggerAudioPlayback();
}

earlyEvents.forEach((evt) => {
  window.addEventListener(evt, onEarlyGesture, { capture: true, passive: true });
  document.addEventListener(evt, onEarlyGesture, { capture: true, passive: true });
});

// Khởi tạo YouTube Iframe API
window.onYouTubeIframeAPIReady = function () {
  ytPlayer = new YT.Player("ytMusicPlayer", {
    height: "200",
    width: "200",
    videoId: "J3IRYx3PzzM",
    playerVars: {
      autoplay: 1,
      controls: 0,
      disablekb: 1,
      enablejsapi: 1,
      fs: 0,
      loop: 1,
      playlist: "J3IRYx3PzzM",
      modestbranding: 1,
      playsinline: 1,
      rel: 0
    },
    events: {
      onReady: onPlayerReady,
      onStateChange: onPlayerStateChange
    }
  });
};

function onPlayerReady(event) {
  // 1. Thử tự động phát có âm thanh
  try {
    event.target.unMute();
    event.target.setVolume(100);
    const p = event.target.playVideo();
    if (p && p.catch) {
      p.catch(() => {
        // Nếu trình duyệt chặn unmuted, phát muted trước để sẵn sàng
        try {
          event.target.mute();
          event.target.playVideo();
        } catch (e) {}
      });
    }
  } catch (err) {}

  // 2. Nếu người dùng đã chạm trước khi player ready, phát có tiếng ngay!
  if (userHasInteracted) {
    try {
      event.target.unMute();
      event.target.setVolume(100);
      event.target.playVideo();
      hideMusicPrompt();
    } catch (e) {}
  }

  // 3. Nút bấm bật/tắt nhạc nổi
  const btnToggle = document.getElementById("btnToggleMusic");
  if (btnToggle) {
    btnToggle.addEventListener("click", (e) => {
      e.stopPropagation();
      userHasInteracted = true;
      hideMusicPrompt();
      if (!ytPlayer) return;

      if (isAudioPlaying) {
        ytPlayer.pauseVideo();
      } else {
        ytPlayer.unMute();
        ytPlayer.setVolume(100);
        ytPlayer.playVideo();
      }
    });
  }
}

function onPlayerStateChange(event) {
  const btnToggle = document.getElementById("btnToggleMusic");
  const musicWidget = document.getElementById("musicWidget");
  const stateIcon = document.getElementById("musicStateIcon");

  // YT.PlayerState.PLAYING === 1
  if (event.data === 1) {
    isAudioPlaying = true;
    hideMusicPrompt();
    if (btnToggle) btnToggle.classList.add("is-playing");
    if (musicWidget) musicWidget.classList.add("is-playing");
    if (stateIcon) stateIcon.textContent = "❚❚";
  } else {
    isAudioPlaying = false;
    if (btnToggle) btnToggle.classList.remove("is-playing");
    if (musicWidget) musicWidget.classList.remove("is-playing");
    if (stateIcon) stateIcon.textContent = "▶";
  }
}
'@

$outPath = "$PSScriptRoot\..\script.js"
[System.IO.File]::WriteAllText($outPath, $jsContent, [System.Text.Encoding]::UTF8)
Write-Host "Wrote updated mobile book script.js successfully!"
