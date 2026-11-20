/**
 * NGỌC TÚ – GRADUATION INVITATION 2026
 * Script xử lý:
 * 1. Đọc URL Query Parameter (?to=...) để cá nhân hóa lời mời
 * 2. Bộ đếm ngược Countdown Timer đến 08:00 ngày 28.11.2026
 * 3. Modal hướng dẫn gửi xe
 */

document.addEventListener("DOMContentLoaded", () => {
  // ================= 1. DỮ LIỆU KHÁCH MỜI CÁ NHÂN HÓA =================
  const GUESTS_DATA = {
    "Nhi": {
      name: "Nhi",
      greeting: "Gửi Nhi thương mến,",
      message: "Cảm ơn Nhi vì đã luôn ở bên cạnh, lắng nghe và chia sẻ cùng Tú qua từng giai đoạn của thời sinh viên. Những buổi chuyện trò, những khoảnh khắc vui buồn có Nhi đồng hành đã làm cho những năm tháng thanh xuân của Tú trở nên trọn vẹn và đáng nhớ hơn bao giờ hết.\n\nNgày 28.11 này, Tú rất mong có Nhi ở bên cạnh để cùng Tú ghi lại dấu mốc quan trọng này nhé! ❤️"
    },
    "Khánh": {
      name: "Khánh",
      greeting: "Gửi Khánh,",
      message: "Bốn năm đại học trôi qua thật nhanh với biết bao kỷ niệm và thử thách. Cảm ơn Khánh vì đã luôn là một người bạn tuyệt vời, luôn đồng hành và tiếp thêm năng lượng tích cực cho Tú trong suốt chặng đường vừa qua.\n\nNgày tốt nghiệp này sẽ thật thiếu trọn vẹn nếu không có Khánh. Hẹn gặp Khánh vào sáng Thứ 7 ngày 28.11 nhé, tụi mình nhất định phải chụp thật nhiều ảnh đẹp cùng nhau nha!"
    },
    "Phát": {
      name: "Phát",
      greeting: "Gửi Phát,",
      message: "Nhìn lại chặng đường 4 năm đại học đã qua, Tú thật sự biết ơn vì luôn có Phát đồng hành và ủng hộ. Cảm ơn những lần hỗ trợ nhiệt tình, những cuộc trò chuyện và sự chân thành mà Phát đã dành cho Tú.\n\nCột mốc tốt nghiệp này là một kỷ niệm vô cùng ý nghĩa của thanh xuân. Tú rất mong được đón Phát đến chung vui và chụp cùng Tú những tấm hình thật đẹp vào ngày 28.11 này nha!"
    },
    "Trang": {
      name: "Trang",
      greeting: "Gửi Trang yêu quý,",
      message: "Cảm ơn Trang vì đã là một phần thật dịu dàng và ấm áp trong những năm tháng đại học của Tú. Cảm ơn những sẻ chia, những nụ cười và sự thấu hiểu mà Trang luôn dành cho Tú suốt thời gian qua.\n\nNgày 28.11 là ngày Tú chính thức khép lại một chương rực rỡ và mở ra hành trình mới. Hãy đến chung vui và lưu lại những khoảnh khắc đáng nhớ nhất cùng Tú nha Trang ơi!"
    },
    "Duy": {
      name: "Duy",
      greeting: "Gửi Duy,",
      message: "Thấm thoát mà 4 năm đại học đã đến đích rồi. Cảm ơn Duy vì đã luôn ở đó, luôn là người bạn đồng hành đáng tin cậy và chia sẻ cùng Tú qua từng mùa thi, từng bài thuyết trình và những deadline căng thẳng.\n\nNgày 28.11 này là một dấu mốc rất đặc biệt đối với Tú. Tú rất mong Duy sẽ có mặt để cùng Tú ăn mừng và lưu lại những khoảnh khắc thanh xuân thật đáng nhớ này nhé!"
    },
    "Thuận": {
      name: "Thuận",
      greeting: "Gửi Thuận,",
      message: "Cảm ơn Thuận vì đã luôn đồng hành, giúp đỡ và mang lại thật nhiều niềm vui trong suốt những năm tháng thanh xuân vừa qua của Tú. Nhờ có những người bạn như Thuận mà chặng đường đại học của Tú đã trở nên vô cùng ý nghĩa và nhiều màu sắc.\n\nSáng ngày 28.11 này, Tú rất vui và hạnh phúc nếu được đón Thuận đến cùng chung vui và chụp thật nhiều bức hình kỷ niệm nha!"
    }
  };

  // Đọc query param ?to= hoặc ?guest=
  const urlParams = new URLSearchParams(window.location.search);
  const rawGuestParam = urlParams.get("to") || urlParams.get("guest") || urlParams.get("name");

  const greetingEl = document.getElementById("guestGreeting");
  const messageEl = document.getElementById("guestMessage");

  if (rawGuestParam) {
    const guestParam = rawGuestParam.trim();
    // Tìm kiếm trong danh sách khách mời (case-insensitive)
    const foundKey = Object.keys(GUESTS_DATA).find(
      key => key.toLowerCase() === guestParam.toLowerCase()
    );

    if (foundKey && GUESTS_DATA[foundKey]) {
      const guest = GUESTS_DATA[foundKey];
      if (greetingEl) greetingEl.textContent = guest.greeting;
      if (messageEl) messageEl.innerHTML = guest.message.replace(/\n/g, "<br>");
      document.title = `${guest.name} ơi, Tú tốt nghiệp rồi nè! 🎓`;
    } else {
      // Khách mời khác không có trong danh sách cố định
      if (greetingEl) greetingEl.textContent = `Gửi ${guestParam} thương mến,`;
      if (messageEl) {
        messageEl.innerHTML = `Có những người không cần đứng trên sân khấu cùng mình, nhưng lại là lý do mình đi được tới đó. Cảm ơn ${guestParam} vì bốn năm thanh xuân vừa qua.<br><br>Ngày 28.11 này, Tú rất mong được đón ${guestParam} đến chung vui và chụp cùng Tú những tấm hình kỷ niệm thật đẹp nha! ❤️`;
      }
      document.title = `${guestParam} ơi, Tú tốt nghiệp rồi nè! 🎓`;
    }
  }

  // ================= 2. BỘ ĐẾM NGƯỢC COUNTDOWN TIMER =================
  // Mục tiêu: 08:00:00 ngày 28 tháng 11 năm 2026 (GMT+7)
  const targetDate = new Date("2026-11-28T08:00:00+07:00").getTime();

  const daysEl = document.getElementById("cdDays");
  const hoursEl = document.getElementById("cdHours");
  const minutesEl = document.getElementById("cdMinutes");
  const secondsEl = document.getElementById("cdSeconds");

  function updateCountdown() {
    const now = new Date().getTime();
    const distance = targetDate - now;

    if (distance <= 0) {
      if (daysEl) daysEl.textContent = "00";
      if (hoursEl) hoursEl.textContent = "00";
      if (minutesEl) minutesEl.textContent = "00";
      if (secondsEl) secondsEl.textContent = "00";
      const titleEl = document.querySelector(".countdown-title");
      if (titleEl) titleEl.innerHTML = "🎉 HÔM NAY LÀ NGÀY TỐT NGHIỆP CỦA TÚ! 🎉";
      return;
    }

    const days = Math.floor(distance / (1000 * 60 * 60 * 24));
    const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
    const seconds = Math.floor((distance % (1000 * 60)) / 1000);

    if (daysEl) daysEl.textContent = String(days).padStart(2, "0");
    if (hoursEl) hoursEl.textContent = String(hours).padStart(2, "0");
    if (minutesEl) minutesEl.textContent = String(minutes).padStart(2, "0");
    if (secondsEl) secondsEl.textContent = String(seconds).padStart(2, "0");
  }

  updateCountdown();
  setInterval(updateCountdown, 1000);

  // ================= 3. MODAL HƯỚNG DẪN GỬI XE =================
  const modal = document.getElementById("parkingModal");
  const btnOpen = document.getElementById("btnParking");
  const btnClose = document.getElementById("btnCloseParking");
  const btnOk = document.getElementById("btnOkParking");

  function openParkingModal() {
    if (modal) {
      modal.removeAttribute("hidden");
      document.body.style.overflow = "hidden";
    }
  }

  function closeParkingModal() {
    if (modal) {
      modal.setAttribute("hidden", "");
      document.body.style.overflow = "";
    }
  }

  if (btnOpen) btnOpen.addEventListener("click", openParkingModal);
  if (btnClose) btnClose.addEventListener("click", closeParkingModal);
  if (btnOk) btnOk.addEventListener("click", closeParkingModal);

  // Đóng modal khi click vào vùng backdrop bên ngoài
  if (modal) {
    modal.addEventListener("click", (e) => {
      if (e.target === modal) {
        closeParkingModal();
      }
    });
  }

  // Đóng bằng phím Escape
  document.addEventListener("keydown", (e) => {
    if (e.key === "Escape" && modal && !modal.hasAttribute("hidden")) {
      closeParkingModal();
    }
  });
});
