/**
 * NGỌC TÚ – GRADUATION INVITATION 2026
 * Script xử lý:
 * 1. Đọc URL Query Parameter (?to=...) để cá nhân hóa tiêu đề trang
 * 2. Trình phát nhạc nền YouTube (Phùng Khánh Linh - Cảm Ơn Người Đã Thức Cùng Tôi)
 *    - Tự động kích hoạt khi người dùng tương tác lần đầu với trang web
 *    - Nút đĩa than bật / tạm dừng nhạc thủ công
 *    - Đĩa than xoay tròn khi nhạc phát
 */

// ================= 1. CÁ NHÂN HÓA TIÊU ĐỀ THEO QUERY PARAM =================
document.addEventListener("DOMContentLoaded", () => {
  const urlParams = new URLSearchParams(window.location.search);
  const rawGuestParam = urlParams.get("to") || urlParams.get("guest") || urlParams.get("name");

  if (rawGuestParam) {
    const guestName = rawGuestParam.trim();
    document.title = `${guestName} ơi, cùng Tú nhìn lại hành trình OU 2022–2026 🎓`;
  }
});

// ================= 2. TRÌNH PHÁT NHẠC NỀN YOUTUBE IFRAME API =================
// Bài hát: Cảm Ơn Người Đã Thức Cùng Tôi - Phùng Khánh Linh (Video ID: J3IRYx3PzzM)
let ytPlayer = null;
let isAudioPlaying = false;
let userHasInteracted = false;

window.onYouTubeIframeAPIReady = function () {
  ytPlayer = new YT.Player("ytMusicPlayer", {
    height: "1",
    width: "1",
    videoId: "J3IRYx3PzzM",
    playerVars: {
      autoplay: 0,
      controls: 0,
      loop: 1,
      playlist: "J3IRYx3PzzM",
      playsinline: 1,
      rel: 0,
      origin: window.location.origin || "*"
    },
    events: {
      onReady: onPlayerReady,
      onStateChange: onPlayerStateChange
    }
  });
};

function onPlayerReady(event) {
  const btnToggle = document.getElementById("btnToggleMusic");

  // Thiết lập phát nhạc khi người dùng tương tác lần đầu (click/chạm bất kỳ đâu trên màn hình)
  function tryAutoPlayOnFirstTouch() {
    if (!userHasInteracted && ytPlayer && ytPlayer.playVideo) {
      userHasInteracted = true;
      ytPlayer.playVideo();
    }
    document.removeEventListener("click", tryAutoPlayOnFirstTouch);
    document.removeEventListener("touchstart", tryAutoPlayOnFirstTouch);
  }

  document.addEventListener("click", tryAutoPlayOnFirstTouch, { once: true });
  document.addEventListener("touchstart", tryAutoPlayOnFirstTouch, { once: true });

  // Nút bấm bật / tắt nhạc thủ công
  if (btnToggle) {
    btnToggle.addEventListener("click", (e) => {
      e.stopPropagation();
      userHasInteracted = true;
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
