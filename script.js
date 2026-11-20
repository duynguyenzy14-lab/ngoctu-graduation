/**
 * NGỌC TÚ – GRADUATION INVITATION 2026
 * 1. Tự động phát nhạc nền YouTube (Phùng Khánh Linh - Cảm Ơn Người Đã Thức Cùng Tôi)
 * 2. Hiệu ứng lật sang trang mới như lật sách 3D (Spread 1: Bìa & Dải phim <-> Spread 2: Thư mời & Thông tin)
 * 3. Cá nhân hóa thư mời theo URL query parameter (?to=Nhi, ?to=Khánh, ?to=Trang...)
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

// ================= 1. CÁ NHÂN HÓA LỜI NHẮN THEO QUERY PARAM =================
document.addEventListener("DOMContentLoaded", () => {
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

  // Khởi tạo hiệu ứng lật trang 3D
  initBookPageFlip();
});

// ================= 2. HIỆU ỨNG LẬT SANG TRANG MỚI NHƯ LẬT SÁCH (3D BOOK PAGE FLIP) =================
function initBookPageFlip() {
  const bookViewport = document.getElementById("bookViewport");
  const spread1 = document.getElementById("spread1");
  const spread2 = document.getElementById("spread2");
  const btnFlipForward = document.getElementById("btnFlipForward");
  const cornerPageCurl = document.getElementById("cornerPageCurl");
  const btnFlipBackward = document.getElementById("btnFlipBackward");
  const cornerPageCurlBack = document.getElementById("cornerPageCurlBack");

  let currentSpread = 1;
  let isAnimating = false;

  function flipToSpread(target) {
    if (isAnimating || currentSpread === target || !bookViewport) return;
    isAnimating = true;

    if (target === 2) {
      // Lật tiến tới Spread 2 (Thư mời & Chi tiết)
      bookViewport.classList.remove("is-turning-backward");
      bookViewport.classList.add("is-turning-forward");

      setTimeout(() => {
        spread1.classList.remove("is-active");
        spread2.classList.add("is-active");
        bookViewport.classList.remove("is-turning-forward");
        currentSpread = 2;
        isAnimating = false;
        if (window.innerWidth < 992) {
          window.scrollTo({ top: 0, behavior: "smooth" });
        }
      }, 700);
    } else {
      // Lật quay về Spread 1 (Bìa & Dải phim 35mm)
      bookViewport.classList.remove("is-turning-forward");
      bookViewport.classList.add("is-turning-backward");

      setTimeout(() => {
        spread2.classList.remove("is-active");
        spread1.classList.add("is-active");
        bookViewport.classList.remove("is-turning-backward");
        currentSpread = 1;
        isAnimating = false;
        if (window.innerWidth < 992) {
          window.scrollTo({ top: 0, behavior: "smooth" });
        }
      }, 700);
    }
  }

  // Bắt sự kiện click các nút lật trang và góc trang sách
  if (btnFlipForward) btnFlipForward.addEventListener("click", () => flipToSpread(2));
  if (cornerPageCurl) cornerPageCurl.addEventListener("click", () => flipToSpread(2));
  if (btnFlipBackward) btnFlipBackward.addEventListener("click", () => flipToSpread(1));
  if (cornerPageCurlBack) cornerPageCurlBack.addEventListener("click", () => flipToSpread(1));

  // Hỗ trợ phím mũi tên bàn phím: Mũi tên phải qua trang, Mũi tên trái về trang
  window.addEventListener("keydown", (e) => {
    if (e.key === "ArrowRight" || e.key === "PageDown") {
      flipToSpread(2);
    } else if (e.key === "ArrowLeft" || e.key === "PageUp") {
      flipToSpread(1);
    }
  });
}

// ================= 3. TRÌNH PHÁT NHẠC NỀN YOUTUBE TỰ ĐỘNG PHÁT =================
// Bài hát: Cảm Ơn Người Đã Thức Cùng Tôi - Phùng Khánh Linh (Video ID: J3IRYx3PzzM)
let ytPlayer = null;
let isAudioPlaying = false;

window.onYouTubeIframeAPIReady = function () {
  ytPlayer = new YT.Player("ytMusicPlayer", {
    events: {
      onReady: onPlayerReady,
      onStateChange: onPlayerStateChange
    }
  });
};

function onPlayerReady(event) {
  const btnToggle = document.getElementById("btnToggleMusic");

  // 1. Kích hoạt phát tự động ngay khi sẵn sàng
  try {
    event.target.playVideo();
  } catch (err) {
    console.log("Autoplay waiting for user interaction:", err);
  }

  // 2. Dự phòng chuẩn W3C Autoplay Policy:
  // Nếu trình duyệt chặn phát âm thanh ban đầu, ngay khi người dùng chạm, click, cuộn chuột hoặc gõ phím,
  // nhạc lập tức phát ngay mà không cần ấn trúng nút nhạc!
  const triggerEvents = ["click", "touchstart", "scroll", "keydown", "wheel", "pointerdown"];
  const startAudioImmediately = () => {
    if (ytPlayer && ytPlayer.playVideo) {
      ytPlayer.playVideo();
    }
    triggerEvents.forEach((evt) => {
      window.removeEventListener(evt, startAudioImmediately, { capture: true, passive: true });
    });
  };

  triggerEvents.forEach((evt) => {
    window.addEventListener(evt, startAudioImmediately, { capture: true, passive: true, once: true });
  });

  // 3. Nút bấm bật / tắt nhạc thủ công trên widget đĩa than
  if (btnToggle) {
    btnToggle.addEventListener("click", (e) => {
      e.stopPropagation();
      if (!ytPlayer || !ytPlayer.playVideo) return;

      if (isAudioPlaying) {
        ytPlayer.pauseVideo();
      } else {
        ytPlayer.playVideo();
      }
    });
  }
}

function onPlayerStateChange(event) {
  const btnToggle = document.getElementById("btnToggleMusic");
  const stateIcon = document.getElementById("musicStateIcon");

  if (event.data === YT.PlayerState.PLAYING) {
    isAudioPlaying = true;
    if (btnToggle) btnToggle.classList.add("is-playing");
    if (stateIcon) stateIcon.textContent = "⏸";
  } else if (event.data === YT.PlayerState.PAUSED || event.data === YT.PlayerState.ENDED) {
    isAudioPlaying = false;
    if (btnToggle) btnToggle.classList.remove("is-playing");
    if (stateIcon) stateIcon.textContent = "▶";
  }
}
