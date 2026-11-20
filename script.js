/**
 * NGỌC TÚ – GRADUATION INVITATION 2026
 * Script xử lý:
 * 1. Đọc URL Query Parameter (?to=...) để cá nhân hóa tiêu đề trang
 * 2. Bộ điều khiển Dải phim 35mm "Hành trình đại học 2022–2026":
 *    - Tự động trôi ngang mượt mà, không giật
 *    - Tự động dừng tại phân cảnh tốt nghiệp 2026
 *    - Nút Phát / Tạm dừng / Xem lại
 *    - Nút Chuyển cảnh Trước / Sau & Thanh mốc thời gian (Timeline)
 *    - Hỗ trợ vuốt chạm trên thiết bị di động (Touch swipe)
 *    - Tương thích prefers-reduced-motion, không phát âm thanh
 */

document.addEventListener("DOMContentLoaded", () => {
  // ================= 1. CÁ NHÂN HÓA TIÊU ĐỀ THEO QUERY PARAM =================
  const urlParams = new URLSearchParams(window.location.search);
  const rawGuestParam = urlParams.get("to") || urlParams.get("guest") || urlParams.get("name");

  if (rawGuestParam) {
    const guestName = rawGuestParam.trim();
    document.title = `${guestName} ơi, cùng Tú nhìn lại hành trình OU 2022–2026 🎓`;
  }

  // ================= 2. BỘ ĐIỀU KHIỂN DẢI PHIM 35MM =================
  const filmTrack = document.getElementById("filmTrack");
  const filmViewport = document.getElementById("filmViewport");
  const btnPrev = document.getElementById("btnFilmPrev");
  const btnNext = document.getElementById("btnFilmNext");
  const btnPlay = document.getElementById("btnFilmPlay");
  const playIcon = document.getElementById("playIcon");
  const playLabel = document.getElementById("playLabel");
  const timelineDots = document.querySelectorAll(".timeline-dot");

  const totalFrames = 4;
  let currentFrame = 0;
  let autoTimer = null;
  const slideInterval = 3800; // 3.8 giây mỗi khung hình để người xem kịp đọc chú thích

  // Kiểm tra cài đặt prefers-reduced-motion
  const prefersReducedMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
  let isPlaying = !prefersReducedMotion;

  // Cập nhật vị trí dải phim
  function updateFilmPosition(isManual = false) {
    if (!filmTrack) return;

    // Di chuyển dải phim theo chiều ngang
    filmTrack.style.transform = `translateX(-${currentFrame * 100}%)`;

    // Cập nhật trạng thái timeline dots
    timelineDots.forEach((dot, index) => {
      const isActive = index === currentFrame;
      dot.classList.toggle("active", isActive);
      dot.setAttribute("aria-selected", isActive ? "true" : "false");
    });

    // Cập nhật trạng thái nút chuyển cảnh (disable ở hai đầu nếu cần hoặc xoay vòng)
    if (btnPrev) btnPrev.style.opacity = currentFrame === 0 ? "0.6" : "1";
    if (btnNext) btnNext.style.opacity = currentFrame === totalFrames - 1 ? "0.6" : "1";

    // Khi đến phân cảnh cuối cùng (Năm 2026 - Tốt nghiệp)
    if (currentFrame === totalFrames - 1) {
      // Dừng tự động phát theo yêu cầu: "Khi kết thúc, dừng tại phân cảnh tốt nghiệp năm 2026"
      stopAutoPlay();
      if (playIcon) playIcon.textContent = "↻";
      if (playLabel) playLabel.textContent = "Xem lại";
    } else if (isPlaying) {
      if (playIcon) playIcon.textContent = "⏸";
      if (playLabel) playLabel.textContent = "Tạm dừng";
    } else {
      if (playIcon) playIcon.textContent = "▶";
      if (playLabel) playLabel.textContent = "Phát tiếp";
    }
  }

  // Chuyển sang phân cảnh tiếp theo
  function nextFrame(isManual = false) {
    if (currentFrame < totalFrames - 1) {
      currentFrame++;
      updateFilmPosition(isManual);
    } else if (isManual) {
      // Nếu bấm nút thủ công ở cuối, cho phép quay về đầu
      currentFrame = 0;
      updateFilmPosition(true);
    } else {
      // Khi tự động chạy đến cuối: Dừng lại ở phân cảnh tốt nghiệp 2026
      stopAutoPlay();
    }
  }

  // Chuyển về phân cảnh trước
  function prevFrame() {
    if (currentFrame > 0) {
      currentFrame--;
      updateFilmPosition(true);
    } else {
      currentFrame = totalFrames - 1;
      updateFilmPosition(true);
    }
  }

  // Bắt đầu tự động chuyển cảnh
  function startAutoPlay() {
    if (prefersReducedMotion) return;
    stopAutoPlay();
    isPlaying = true;
    if (playIcon) playIcon.textContent = "⏸";
    if (playLabel) playLabel.textContent = "Tạm dừng";

    autoTimer = setInterval(() => {
      nextFrame(false);
    }, slideInterval);
  }

  // Tạm dừng tự động chuyển cảnh
  function stopAutoPlay() {
    if (autoTimer) {
      clearInterval(autoTimer);
      autoTimer = null;
    }
    isPlaying = false;
  }

  // Xử lý nút Phát / Tạm dừng / Xem lại
  if (btnPlay) {
    btnPlay.addEventListener("click", () => {
      if (currentFrame === totalFrames - 1) {
        // Nếu đang ở phân cảnh 2026 và bấm Xem lại: quay về đầu và bắt đầu phát
        currentFrame = 0;
        updateFilmPosition(true);
        startAutoPlay();
      } else if (isPlaying) {
        stopAutoPlay();
        if (playIcon) playIcon.textContent = "▶";
        if (playLabel) playLabel.textContent = "Phát tiếp";
      } else {
        startAutoPlay();
      }
    });
  }

  // Nút Chuyển cảnh Trước
  if (btnPrev) {
    btnPrev.addEventListener("click", () => {
      stopAutoPlay();
      prevFrame();
      if (playIcon && currentFrame < totalFrames - 1) {
        playIcon.textContent = "▶";
        if (playLabel) playLabel.textContent = "Phát tiếp";
      }
    });
  }

  // Nút Chuyển cảnh Tiếp theo
  if (btnNext) {
    btnNext.addEventListener("click", () => {
      stopAutoPlay();
      nextFrame(true);
      if (playIcon && currentFrame < totalFrames - 1) {
        playIcon.textContent = "▶";
        if (playLabel) playLabel.textContent = "Phát tiếp";
      }
    });
  }

  // Bấm vào mốc thời gian Timeline
  timelineDots.forEach(dot => {
    dot.addEventListener("click", () => {
      stopAutoPlay();
      const targetIndex = parseInt(dot.getAttribute("data-target"), 10);
      if (!isNaN(targetIndex) && targetIndex >= 0 && targetIndex < totalFrames) {
        currentFrame = targetIndex;
        updateFilmPosition(true);
        if (playIcon && currentFrame < totalFrames - 1) {
          playIcon.textContent = "▶";
          if (playLabel) playLabel.textContent = "Phát tiếp";
        }
      }
    });
  });

  // Hỗ trợ phím mũi tên bàn phím khi người dùng focus vào khung phim
  if (filmViewport) {
    filmViewport.addEventListener("keydown", (e) => {
      if (e.key === "ArrowLeft") {
        e.preventDefault();
        stopAutoPlay();
        prevFrame();
      } else if (e.key === "ArrowRight") {
        e.preventDefault();
        stopAutoPlay();
        nextFrame(true);
      } else if (e.key === " ") {
        e.preventDefault();
        if (btnPlay) btnPlay.click();
      }
    });
  }

  // ================= VUỐT CHẠM TRÊN THIẾT BỊ DI ĐỘNG (TOUCH SWIPE) =================
  let touchStartX = 0;
  let touchEndX = 0;

  if (filmViewport) {
    filmViewport.addEventListener("touchstart", (e) => {
      touchStartX = e.changedTouches[0].screenX;
    }, { passive: true });

    filmViewport.addEventListener("touchend", (e) => {
      touchEndX = e.changedTouches[0].screenX;
      handleSwipe();
    }, { passive: true });
  }

  function handleSwipe() {
    const swipeThreshold = 45; // Khoảng cách vuốt tối thiểu
    const diff = touchEndX - touchStartX;

    if (Math.abs(diff) > swipeThreshold) {
      stopAutoPlay();
      if (diff < 0) {
        // Vuốt sang trái -> Xem ảnh tiếp theo
        nextFrame(true);
      } else {
        // Vuốt sang phải -> Xem ảnh trước
        prevFrame();
      }
      if (playIcon && currentFrame < totalFrames - 1) {
        playIcon.textContent = "▶";
        if (playLabel) playLabel.textContent = "Phát tiếp";
      }
    }
  }

  // Khởi chạy dải phim
  updateFilmPosition();
  if (isPlaying) {
    startAutoPlay();
  }
});
