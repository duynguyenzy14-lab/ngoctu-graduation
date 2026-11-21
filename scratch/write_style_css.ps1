$cssContent = @'
/* ==========================================================================
   NGỌC TÚ – GRADUATION INVITATION 2026
   Style: Pastel Pink · Scrapbook × Editorial × 3D Mobile Book Flip
   Typography: Playfair Display unified across entire site (except 35mm film monospace)
   Layout: Mobile-first vertical format (Định dạng dọc, tối ưu giao diện điện thoại)
   ========================================================================== */

/* ================= 1. CẤU HÌNH BIẾN & TONE MÀU SẮC ================= */
:root {
  /* Typography - Toàn bộ font chữ trên trang đồng nhất theo Playfair Display */
  --font-main: 'Playfair Display', Georgia, serif;
  --font-editorial: 'Playfair Display', Georgia, serif;
  --font-handwrite: 'Playfair Display', Georgia, serif;
  --font-film-meta: 'Courier New', Courier, monospace, sans-serif;

  /* Bảng màu Pastel Pink & Creamy Scrapbook */
  --bg-creamy: #FFFDF9;
  --bg-cream-blush: #FFF4F8;
  --bg-card: rgba(255, 255, 255, 0.92);
  --pink-pastel: #FCE8F0;
  --pink-pastel-light: #FFF0F6;
  --pink-border: #F8D3E2;
  --pink-dashed: rgba(232, 39, 94, 0.38);

  /* Hồng nhấn (Accent & Highlights) */
  --pink-accent: #E8275E;
  --pink-accent-hover: #D0184E;
  --pink-accent-soft: rgba(232, 39, 94, 0.12);

  /* Màu chữ */
  --text-dark: #382830;
  --text-muted: #7A626F;
  --text-light: #9E8592;

  /* Chi tiết scrapbook */
  --washi-bg: rgba(255, 185, 205, 0.75);
  --shadow-polaroid: 0 16px 36px -10px rgba(120, 20, 60, 0.16), 0 2px 8px rgba(0, 0, 0, 0.04);
  --shadow-card: 0 16px 40px -12px rgba(180, 45, 90, 0.14), 0 3px 12px rgba(0, 0, 0, 0.03);
}

/* ================= 2. RESET & CƠ BẢN TỐI ƯU CHO MOBILE ================= */
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
  -webkit-tap-highlight-color: transparent;
}

html, body {
  width: 100%;
  min-height: 100%;
  min-height: 100dvh;
  background-color: var(--bg-creamy);
  font-family: var(--font-main);
  color: var(--text-dark);
  line-height: 1.6;
  overflow-x: hidden;
  -webkit-font-smoothing: antialiased;
}

/* Nền caro hồng kem vintage mềm mại */
body {
  background-image: 
    linear-gradient(rgba(240, 175, 195, 0.15) 1px, transparent 1px),
    linear-gradient(90deg, rgba(240, 175, 195, 0.15) 1px, transparent 1px),
    linear-gradient(145deg, #FFFDF9 0%, #FFF5F8 45%, #FCEAF2 100%);
  background-size: 22px 22px, 22px 22px, 100% 100%;
  background-attachment: fixed;
}

button, input, select, textarea {
  font-family: inherit;
}

/* ================= 3. BỐ CỤC KHUNG SÁCH ĐỊNH DẠNG DỌC (MOBILE-FIRST) ================= */
.invitation-screen {
  width: 100%;
  max-width: 480px; /* Chuẩn khung hình điện thoại tối ưu trải nghiệm cầm tay */
  min-height: 100dvh;
  margin: 0 auto;
  position: relative;
  display: flex;
  flex-direction: column;
  padding: 12px 14px 85px; /* Chừa khoảng dưới cho widget nhạc */
}

/* Thanh điều hướng chỉ báo trang (Page indicator dots) */
.book-nav-indicator {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 6px;
  padding: 8px 0 14px;
  width: 100%;
  z-index: 50;
}

.nav-dots {
  display: flex;
  gap: 10px;
  align-items: center;
}

.nav-dot {
  width: 28px;
  height: 28px;
  border-radius: 50%;
  border: 1.5px solid var(--pink-border);
  background: rgba(255, 255, 255, 0.85);
  color: var(--text-muted);
  font-family: var(--font-editorial);
  font-size: 12px;
  font-weight: 700;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.2, 0.8, 0.2, 1);
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.03);
}

.nav-dot.is-active {
  background: var(--pink-accent);
  color: #FFFFFF;
  border-color: var(--pink-accent);
  transform: scale(1.15);
  box-shadow: 0 4px 12px rgba(232, 39, 94, 0.35);
}

.nav-page-label {
  font-family: var(--font-editorial);
  font-style: italic;
  font-size: 12px;
  font-weight: 600;
  color: var(--pink-accent);
  letter-spacing: 0.02em;
}

/* ================= 4. HIỆU ỨNG LẬT SÁCH 3D (BOOK PAGE FLIP) ================= */
.book-viewport {
  width: 100%;
  position: relative;
  perspective: 2000px;
  perspective-origin: center center;
}

.book-page {
  width: 100%;
  display: none;
  opacity: 0;
  visibility: hidden;
  transform-style: preserve-3d;
  transition: opacity 0.4s ease;
  position: relative;
}

.book-page.is-active {
  display: block;
  opacity: 1;
  visibility: visible;
  z-index: 10;
}

/* Hiệu ứng lật trang 3D chân thực */
.book-viewport.is-turning-forward .book-page.is-turning-out {
  display: block;
  animation: flipPageForwardOut 0.65s cubic-bezier(0.645, 0.045, 0.355, 1) forwards;
}

.book-viewport.is-turning-forward .book-page.is-turning-in {
  display: block;
  animation: flipPageForwardIn 0.65s cubic-bezier(0.645, 0.045, 0.355, 1) forwards;
}

.book-viewport.is-turning-backward .book-page.is-turning-out {
  display: block;
  animation: flipPageBackwardOut 0.65s cubic-bezier(0.645, 0.045, 0.355, 1) forwards;
}

.book-viewport.is-turning-backward .book-page.is-turning-in {
  display: block;
  animation: flipPageBackwardIn 0.65s cubic-bezier(0.645, 0.045, 0.355, 1) forwards;
}

@keyframes flipPageForwardOut {
  0% {
    transform: rotateY(0deg) scale(1);
    opacity: 1;
  }
  50% {
    transform: rotateY(-50deg) scale(0.96);
    opacity: 0.85;
    box-shadow: -15px 0 35px rgba(180, 40, 80, 0.25);
  }
  100% {
    transform: rotateY(-95deg) scale(0.92);
    opacity: 0;
  }
}

@keyframes flipPageForwardIn {
  0% {
    transform: rotateY(95deg) scale(0.92);
    opacity: 0;
  }
  50% {
    transform: rotateY(35deg) scale(0.96);
    opacity: 0.9;
  }
  100% {
    transform: rotateY(0deg) scale(1);
    opacity: 1;
  }
}

@keyframes flipPageBackwardOut {
  0% {
    transform: rotateY(0deg) scale(1);
    opacity: 1;
  }
  50% {
    transform: rotateY(50deg) scale(0.96);
    opacity: 0.85;
  }
  100% {
    transform: rotateY(95deg) scale(0.92);
    opacity: 0;
  }
}

@keyframes flipPageBackwardIn {
  0% {
    transform: rotateY(-95deg) scale(0.92);
    opacity: 0;
  }
  50% {
    transform: rotateY(-35deg) scale(0.96);
    opacity: 0.9;
  }
  100% {
    transform: rotateY(0deg) scale(1);
    opacity: 1;
  }
}

/* ================= 5. MỖI SECTION LÀ ĐƯỜNG LINE ĐỨT SCRAPBOOK (PAGE CARD) ================= */
.page-card-dashed {
  width: 100%;
  background: var(--bg-card);
  border: 2px dashed var(--pink-dashed) !important; /* Mỗi section là đường line đứt */
  border-radius: clamp(20px, 5vw, 26px);
  padding: clamp(22px, 5vw, 30px) clamp(16px, 4vw, 22px) clamp(28px, 6vw, 38px);
  box-shadow: var(--shadow-card);
  backdrop-filter: blur(10px);
  position: relative;
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
  box-sizing: border-box;
}

/* ================= 6. TRANG 1 (SECTION 01): BÌA POLAROID & NAMEPLATE ================= */
.polaroid-wrapper {
  position: relative;
  width: 100%;
  max-width: clamp(260px, 72vw, 300px);
  margin: 0 auto clamp(16px, 3.5vh, 22px);
  transform: rotate(-1deg);
  transition: transform 0.4s cubic-bezier(0.2, 0.8, 0.2, 1);
}

.polaroid-wrapper:hover,
.polaroid-wrapper:active {
  transform: rotate(0deg) scale(1.02);
}

.polaroid-inner {
  background: #FFFFFF;
  border-radius: 12px;
  padding: 12px 12px clamp(16px, 3.5vw, 22px);
  box-shadow: var(--shadow-polaroid);
  border: 1px solid rgba(240, 180, 200, 0.45);
  display: flex;
  flex-direction: column;
  align-items: center;
}

.photo-container {
  width: 100%;
  aspect-ratio: 4/5;
  overflow: hidden;
  border-radius: 4px;
  background: #FFF5F8;
  position: relative;
}

.polaroid-photo {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: center top;
  display: block;
}

.polaroid-caption {
  width: 100%;
  padding-top: 14px;
  padding-bottom: 2px;
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
}

.polaroid-caption-text {
  font-family: var(--font-editorial);
  font-style: italic;
  font-size: clamp(15.5px, 4vw, 19.5px);
  font-weight: 500;
  color: var(--pink-accent);
  letter-spacing: 0.025em;
  line-height: 1.35;
  white-space: nowrap;
}

/* Khối Personal Nameplate */
.personal-nameplate {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  width: 100%;
  margin-top: 2px;
  margin-bottom: 8px;
}

.nameplate-subhead {
  font-family: var(--font-editorial);
  font-style: italic;
  font-size: clamp(17px, 4.2vw, 22px);
  font-weight: 500;
  color: var(--pink-accent);
  letter-spacing: 0.02em;
  line-height: 1.25;
  margin-bottom: 5px;
}

.nameplate-fullname {
  font-family: var(--font-editorial);
  font-size: clamp(26px, 6.8vw, 34px);
  font-weight: 800;
  letter-spacing: 0.01em;
  line-height: 1.15;
  color: var(--text-dark);
  text-transform: uppercase;
  margin-bottom: 6px;
}

.nameplate-major {
  font-family: var(--font-editorial);
  font-size: clamp(12.5px, 3.2vw, 14px);
  font-weight: 700;
  letter-spacing: 0.18em;
  color: var(--text-muted);
  text-transform: uppercase;
}

/* ================= 7. TRANG 2 (SECTION 02): DẢI PHIM 35MM HÀNH TRÌNH OU ================= */
.film-header {
  text-align: center;
  margin-bottom: 12px;
  width: 100%;
}

.film-header-badge {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  background: rgba(255, 255, 255, 0.95);
  border: 1px solid rgba(232, 39, 94, 0.22);
  padding: 4px 14px;
  border-radius: 999px;
  margin-bottom: 8px;
  font-family: var(--font-editorial);
  font-size: 11px;
  font-weight: 700;
  letter-spacing: 0.1em;
  color: var(--pink-accent);
  text-transform: uppercase;
  box-shadow: 0 2px 6px rgba(232, 39, 94, 0.08);
}

.film-main-title {
  font-family: var(--font-editorial);
  font-size: clamp(13.5px, 3.8vw, 17.5px);
  font-weight: 800;
  color: var(--pink-accent);
  text-transform: uppercase;
  letter-spacing: 0.015em;
  line-height: 1.25;
  margin-bottom: 6px;
  white-space: nowrap;
  width: 100%;
  text-align: center;
}

.film-sub-text {
  font-family: var(--font-editorial);
  font-size: clamp(12px, 3vw, 13.5px);
  color: var(--text-muted);
  line-height: 1.55;
  font-style: italic;
  font-weight: 500;
  margin: 0 auto;
  max-width: 380px;
}

.film-strip-card {
  position: relative;
  background: #FFFDFD;
  border: 1.5px solid var(--pink-border);
  border-radius: clamp(16px, 3.5vw, 20px);
  padding: 12px 8px;
  box-shadow: var(--shadow-card);
  width: 100%;
  margin-top: 10px;
}

.film-washi-tape {
  position: absolute;
  top: -10px;
  left: 50%;
  transform: translateX(-50%) rotate(0.8deg);
  width: 85px;
  height: 20px;
  background-color: var(--washi-bg);
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.06);
  backdrop-filter: blur(2px);
  z-index: 5;
  clip-path: polygon(4% 0%, 96% 0%, 100% 100%, 0% 100%);
}

.film-35mm-reel {
  background: #1C1318;
  border-radius: 10px;
  padding: 6px 0;
  box-shadow: 0 16px 36px -10px rgba(35, 12, 22, 0.45), inset 0 0 0 1px rgba(255, 255, 255, 0.08);
  overflow: hidden;
  position: relative;
}

.film-perforation-bar {
  width: 100%;
  padding: 2px 0;
  user-select: none;
}

.sprocket-holes {
  height: 12px;
  width: 100%;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='12' viewBox='0 0 16 12'%3E%3Crect x='3' y='1' width='10' height='10' rx='2.2' fill='%23FFFDF9' opacity='0.92'/%3E%3C/svg%3E");
  background-repeat: repeat-x;
}

/* Thông số phim: giữ nguyên font monospace như máy ảnh film theo yêu cầu */
.film-meta-text {
  font-family: var(--font-film-meta) !important;
  font-size: 8px;
  font-weight: 700;
  letter-spacing: 0.12em;
  color: #FFA3C7;
  text-transform: uppercase;
  display: flex;
  justify-content: space-between;
  padding: 2px 8px 1px;
  opacity: 0.88;
}

.film-marquee-viewport {
  width: 100%;
  overflow: hidden;
  position: relative;
  padding: 6px 0;
  -webkit-mask-image: linear-gradient(90deg, transparent 0%, #000 4%, #000 96%, transparent 100%);
  mask-image: linear-gradient(90deg, transparent 0%, #000 4%, #000 96%, transparent 100%);
}

.film-marquee-track {
  display: flex;
  gap: 10px;
  width: max-content;
  animation: filmMarqueeScroll 55s linear infinite;
  will-change: transform;
}

.film-marquee-track:hover {
  animation-play-state: paused;
}

@keyframes filmMarqueeScroll {
  0% { transform: translateX(0); }
  100% { transform: translateX(-50%); }
}

.film-frame-item {
  position: relative;
  flex-shrink: 0;
  height: clamp(140px, 32vw, 165px);
  background: #251B20;
  border-radius: 4px;
  overflow: hidden;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.35);
}

.film-frame-item.is-landscape {
  width: clamp(210px, 48vw, 248px);
}

.film-frame-item.is-landscape-wide {
  width: clamp(245px, 56vw, 288px);
}

.film-frame-item.is-portrait {
  width: clamp(105px, 24vw, 124px);
}

.film-frame-item.is-portrait-23 {
  width: clamp(94px, 21vw, 110px);
}

.film-frame-item.is-square {
  width: clamp(140px, 32vw, 165px);
}

.film-photo {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

/* ================= 8. TRANG 3 (SECTION 03): THƯ MỜI THÂN THƯƠNG ================= */
.letter-scrapbook-card {
  position: relative;
  width: 100%;
  text-align: left;
}

.letter-washi {
  position: absolute;
  top: -16px;
  left: 20px;
  width: 65px;
  height: 18px;
  background: var(--washi-bg);
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  transform: rotate(-3deg);
  clip-path: polygon(5% 0%, 95% 0%, 100% 100%, 0% 100%);
}

.wax-seal-stamp {
  position: absolute;
  top: -14px;
  right: 12px;
  width: 48px;
  height: 48px;
  border-radius: 50%;
  background: radial-gradient(circle, #E8275E 20%, #B81545 70%, #900B32 100%);
  box-shadow: 0 6px 14px rgba(180, 20, 70, 0.35), inset 0 2px 4px rgba(255, 255, 255, 0.35);
  display: flex;
  align-items: center;
  justify-content: center;
  transform: rotate(8deg);
  user-select: none;
}

.wax-seal-inner {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  border: 1.5px dashed rgba(255, 255, 255, 0.65);
  border-radius: 50%;
  width: 38px;
  height: 38px;
  color: #FFFDF9;
  line-height: 1.1;
}

.seal-school {
  font-family: var(--font-editorial);
  font-size: 13px;
  font-weight: 800;
  letter-spacing: 0.05em;
}

.seal-year {
  font-size: 9px;
  font-weight: 700;
  opacity: 0.9;
}

.letter-header {
  margin-top: 14px;
  margin-bottom: 12px;
}

.letter-place-date {
  font-family: var(--font-editorial);
  font-style: italic;
  font-size: 13.5px;
  color: var(--pink-accent);
  margin-bottom: 8px;
}

.letter-salutation {
  font-family: var(--font-editorial);
  font-size: clamp(20px, 5.2vw, 24px);
  font-weight: 700;
  color: var(--text-dark);
}

.letter-content {
  display: flex;
  flex-direction: column;
  gap: 12px;
  font-size: clamp(13.5px, 3.4vw, 15px);
  color: var(--text-dark);
  line-height: 1.7;
}

.letter-paragraph.highlight-msg {
  color: var(--pink-accent);
  font-weight: 600;
  background: rgba(252, 232, 240, 0.5);
  padding: 10px 12px;
  border-radius: 8px;
  border-left: 3px solid var(--pink-accent);
}

.letter-footer {
  margin-top: 18px;
  padding-top: 12px;
  border-top: 1px dashed rgba(232, 39, 94, 0.2);
}

.letter-sign-close {
  font-family: var(--font-editorial);
  font-style: italic;
  font-size: 14px;
  color: var(--text-muted);
}

.letter-signature {
  font-family: var(--font-editorial);
  font-style: italic;
  font-size: 26px;
  font-weight: 700;
  color: var(--pink-accent);
  margin-top: 2px;
}

/* ================= 9. TRANG 4 (SECTION 04): CHI TIẾT LỄ TỐT NGHIỆP ================= */
.details-header {
  text-align: center;
  margin-bottom: 14px;
  width: 100%;
}

.details-badge {
  display: inline-block;
  background: rgba(255, 255, 255, 0.95);
  border: 1px solid rgba(232, 39, 94, 0.22);
  padding: 4px 14px;
  border-radius: 999px;
  margin-bottom: 8px;
  font-family: var(--font-editorial);
  font-size: 10.5px;
  font-weight: 800;
  letter-spacing: 0.1em;
  color: var(--pink-accent);
  text-transform: uppercase;
}

.details-main-title {
  font-family: var(--font-editorial);
  font-size: clamp(17px, 4.5vw, 22px);
  font-weight: 800;
  color: var(--pink-accent);
  text-transform: uppercase;
  letter-spacing: 0.02em;
  line-height: 1.25;
  margin-bottom: 3px;
}

.details-sub-tag {
  font-family: var(--font-editorial);
  font-size: 11px;
  font-weight: 700;
  color: var(--text-muted);
  letter-spacing: 0.08em;
  text-transform: uppercase;
}

.ceremony-info-card {
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 12px;
  text-align: left;
}

.info-item-row {
  display: flex;
  gap: 10px;
  align-items: flex-start;
}

.info-row-icon {
  font-size: 18px;
  flex-shrink: 0;
  margin-top: 2px;
}

.info-row-text {
  display: flex;
  flex-direction: column;
}

.info-row-label {
  font-family: var(--font-editorial);
  font-size: 11px;
  font-weight: 700;
  color: var(--text-muted);
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.info-row-value {
  font-family: var(--font-editorial);
  font-size: 14px;
  font-weight: 700;
  color: var(--text-dark);
}

.info-item-row.highlight-box {
  background: linear-gradient(135deg, #FFF0F6 0%, #FFEBF3 100%);
  border: 1px solid rgba(232, 39, 94, 0.25);
  border-radius: 12px;
  padding: 10px 12px;
}

.photo-time {
  font-family: var(--font-editorial);
  font-size: 16.5px;
  color: var(--pink-accent);
  font-weight: 800;
}

.info-row-desc {
  font-family: var(--font-editorial);
  font-size: 11.5px;
  color: var(--text-muted);
  margin-top: 2px;
  font-style: italic;
}

.parking-list {
  list-style: none;
  padding: 0;
  margin-top: 3px;
  font-family: var(--font-editorial);
  font-size: 12px;
  color: var(--text-dark);
  line-height: 1.45;
}

.details-action-wrap {
  margin-top: 4px;
  width: 100%;
}

.btn-maps-action {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  width: 100%;
  background: linear-gradient(135deg, var(--pink-accent) 0%, #C81E50 100%);
  color: #FFFFFF;
  text-decoration: none;
  font-family: var(--font-editorial);
  font-size: 13px;
  font-weight: 700;
  border-radius: 10px;
  padding: 10px 14px;
  box-shadow: 0 4px 14px rgba(232, 39, 94, 0.3);
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.btn-maps-action:active {
  transform: scale(0.98);
}

/* ================= 10. NÚT ĐIỀU HƯỚNG LẬT TRANG (PAGE ACTION BUTTONS) ================= */
.page-action-row {
  margin-top: 18px;
  width: 100%;
  display: flex;
  justify-content: center;
  gap: 10px;
  z-index: 20;
}

.page-action-row.dual-action {
  justify-content: space-between;
}

.btn-flip-page {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  background: linear-gradient(135deg, #FFF2F7 0%, #FFE5F0 100%);
  border: 1.5px solid rgba(232, 39, 94, 0.35);
  border-radius: 999px;
  padding: 9px 18px;
  font-family: var(--font-editorial);
  font-size: 13px;
  font-weight: 700;
  color: var(--pink-accent);
  box-shadow: 0 4px 14px -3px rgba(232, 39, 94, 0.2);
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.2, 0.8, 0.2, 1);
}

.btn-flip-page:hover,
.btn-flip-page:active {
  background: var(--pink-accent);
  color: #FFFFFF;
  transform: translateY(-2px);
  box-shadow: 0 8px 20px -3px rgba(232, 39, 94, 0.38);
  border-color: var(--pink-accent);
}

.btn-flip-page.btn-prev {
  background: rgba(255, 255, 255, 0.9);
  color: var(--text-muted);
  border-color: rgba(232, 39, 94, 0.25);
}

.btn-flip-page.btn-prev:hover,
.btn-flip-page.btn-prev:active {
  background: var(--pink-accent);
  color: #FFFFFF;
}

.flip-btn-icon {
  display: inline-block;
  font-size: 13px;
  transition: transform 0.3s ease;
}

.btn-flip-page:hover .flip-btn-icon {
  transform: translateX(3px);
}

.btn-flip-page.btn-prev:hover .flip-btn-icon {
  transform: translateX(-3px);
}

/* Góc giấy gấp 3D lật trang (Corner Page Curl) */
.corner-page-curl {
  position: absolute;
  bottom: 0;
  right: 0;
  width: 55px;
  height: 55px;
  cursor: pointer;
  z-index: 25;
  transition: transform 0.3s cubic-bezier(0.2, 0.8, 0.2, 1);
}

.corner-page-curl:active {
  transform: scale(1.1);
}

.curl-fold {
  position: absolute;
  bottom: 0;
  right: 0;
  width: 0;
  height: 0;
  border-style: solid;
  border-width: 0 0 44px 44px;
  border-color: transparent transparent #FFD0E2 transparent;
  filter: drop-shadow(-3px -3px 5px rgba(180, 40, 90, 0.2));
  transition: all 0.3s ease;
}

.curl-hint {
  position: absolute;
  bottom: 6px;
  right: 6px;
  font-family: var(--font-editorial);
  font-style: italic;
  font-size: 10px;
  font-weight: 700;
  color: var(--pink-accent);
  transform: rotate(-45deg);
  pointer-events: none;
  white-space: nowrap;
}

.corner-page-curl.curl-left-bottom {
  right: auto;
  left: 0;
}

.curl-fold-left {
  position: absolute;
  bottom: 0;
  left: 0;
  width: 0;
  height: 0;
  border-style: solid;
  border-width: 0 44px 44px 0;
  border-color: transparent #FFD0E2 transparent transparent;
  filter: drop-shadow(3px -3px 5px rgba(180, 40, 90, 0.2));
}

.curl-left-bottom .curl-hint {
  right: auto;
  left: 6px;
  transform: rotate(45deg);
}

/* ================= 11. WIDGET NHẠC NỀN COQUETTE TỰ ĐỘNG PHÁT ================= */
.music-floating-widget {
  position: fixed;
  bottom: 16px;
  right: 16px;
  z-index: 9999;
}

.music-autoplay-prompt {
  position: absolute;
  bottom: calc(100% + 8px);
  right: 0;
  background: var(--pink-accent);
  color: #FFFFFF;
  padding: 5px 12px;
  border-radius: 999px;
  font-family: var(--font-editorial);
  font-size: 11px;
  font-weight: 700;
  white-space: nowrap;
  box-shadow: 0 4px 14px rgba(232, 39, 94, 0.35);
  pointer-events: none;
  animation: promptBounce 2s infinite ease-in-out;
  transition: opacity 0.3s ease, transform 0.3s ease;
}

.music-autoplay-prompt::after {
  content: "";
  position: absolute;
  top: 100%;
  right: 20px;
  border-width: 5px;
  border-style: solid;
  border-color: var(--pink-accent) transparent transparent transparent;
}

.music-floating-widget.is-playing .music-autoplay-prompt,
.music-autoplay-prompt.is-hidden {
  opacity: 0;
  visibility: hidden;
  transform: translateY(6px);
}

@keyframes promptBounce {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-4px); }
}

.btn-music-toggle {
  display: flex;
  align-items: center;
  gap: 10px;
  background: rgba(255, 253, 253, 0.94);
  border: 1px solid rgba(232, 39, 94, 0.28);
  border-radius: 999px;
  padding: 6px 14px 6px 8px;
  box-shadow: 0 8px 24px -4px rgba(120, 20, 60, 0.16), 0 2px 8px rgba(0, 0, 0, 0.04);
  backdrop-filter: blur(8px);
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.2, 0.8, 0.2, 1);
  color: var(--text-dark);
  text-align: left;
}

.btn-music-toggle:active {
  transform: scale(0.96);
}

.vinyl-record {
  width: 34px;
  height: 34px;
  border-radius: 50%;
  background: radial-gradient(circle, #2C2026 25%, #181115 50%, #2A1E24 75%, #110B0E 100%);
  border: 1px solid rgba(255, 255, 255, 0.15);
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 3px 8px rgba(0, 0, 0, 0.25);
  flex-shrink: 0;
  animation: spinRecord 3.5s linear infinite;
  animation-play-state: paused;
}

.btn-music-toggle.is-playing .vinyl-record {
  animation-play-state: running;
}

@keyframes spinRecord {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

.vinyl-core {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background: linear-gradient(135deg, #FFA0BE 0%, #E8275E 100%);
  border: 2px solid #FFFDF9;
}

.music-details {
  display: flex;
  flex-direction: column;
}

.music-tag {
  font-family: var(--font-editorial);
  font-size: 8.5px;
  font-weight: 800;
  letter-spacing: 0.1em;
  color: var(--pink-accent);
  text-transform: uppercase;
}

.music-title {
  font-family: var(--font-editorial);
  font-size: 12px;
  font-weight: 700;
  color: var(--text-dark);
  line-height: 1.25;
  white-space: nowrap;
  max-width: 150px;
  overflow: hidden;
  text-overflow: ellipsis;
}

.music-artist {
  font-family: var(--font-editorial);
  font-size: 10px;
  color: var(--text-muted);
}

.music-state-icon {
  width: 24px;
  height: 24px;
  border-radius: 50%;
  background: #FFF0F5;
  color: var(--pink-accent);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 10px;
  font-weight: 700;
  flex-shrink: 0;
  margin-left: 2px;
}
'@

$outPath = "$PSScriptRoot\..\style.css"
[System.IO.File]::WriteAllText($outPath, $cssContent, [System.Text.Encoding]::UTF8)
Write-Host "Wrote updated mobile book style.css successfully!"
