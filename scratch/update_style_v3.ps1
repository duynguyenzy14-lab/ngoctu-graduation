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
  --bg-card: rgba(255, 255, 255, 0.94);
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
  max-width: 460px; /* Chuẩn khung hình điện thoại tối ưu trải nghiệm cầm tay */
  min-height: 100dvh;
  margin: 0 auto;
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: clamp(14px, 3vh, 22px) 14px clamp(20px, 3.5vh, 28px);
  box-sizing: border-box;
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
  transform-style: preserve-3d;
  backface-visibility: hidden;
  will-change: transform, opacity;
}

.book-page.is-active {
  display: block;
}

/* Hiệu ứng lật trang tới (Forward Flip: Trang cũ gập sang trái, trang mới mở ra) */
.book-viewport.is-turning-forward .book-page.is-turning-out {
  display: block;
  animation: turnPageForwardOut 0.65s cubic-bezier(0.4, 0, 0.2, 1) forwards;
  transform-origin: left center;
  pointer-events: none;
}

.book-viewport.is-turning-forward .book-page.is-turning-in {
  display: block;
  animation: turnPageForwardIn 0.65s cubic-bezier(0.4, 0, 0.2, 1) forwards;
  transform-origin: right center;
}

@keyframes turnPageForwardOut {
  0% {
    transform: rotateY(0deg) scale(1);
    opacity: 1;
    filter: drop-shadow(0 8px 20px rgba(0,0,0,0.08));
  }
  50% {
    opacity: 0.85;
    filter: drop-shadow(-10px 10px 24px rgba(0,0,0,0.18));
  }
  100% {
    transform: rotateY(-90deg) scale(0.92);
    opacity: 0;
    filter: drop-shadow(-20px 15px 30px rgba(0,0,0,0.25));
  }
}

@keyframes turnPageForwardIn {
  0% {
    transform: rotateY(90deg) scale(0.92);
    opacity: 0;
    filter: drop-shadow(20px 15px 30px rgba(0,0,0,0.25));
  }
  50% {
    opacity: 0.85;
    filter: drop-shadow(10px 10px 24px rgba(0,0,0,0.18));
  }
  100% {
    transform: rotateY(0deg) scale(1);
    opacity: 1;
    filter: drop-shadow(0 8px 20px rgba(0,0,0,0.08));
  }
}

/* Hiệu ứng lật trang lui (Backward Flip) */
.book-viewport.is-turning-backward .book-page.is-turning-out {
  display: block;
  animation: turnPageBackwardOut 0.65s cubic-bezier(0.4, 0, 0.2, 1) forwards;
  transform-origin: right center;
  pointer-events: none;
}

.book-viewport.is-turning-backward .book-page.is-turning-in {
  display: block;
  animation: turnPageBackwardIn 0.65s cubic-bezier(0.4, 0, 0.2, 1) forwards;
  transform-origin: left center;
}

@keyframes turnPageBackwardOut {
  0% {
    transform: rotateY(0deg) scale(1);
    opacity: 1;
  }
  100% {
    transform: rotateY(90deg) scale(0.92);
    opacity: 0;
  }
}

@keyframes turnPageBackwardIn {
  0% {
    transform: rotateY(-90deg) scale(0.92);
    opacity: 0;
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
  padding: clamp(20px, 4.5vw, 28px) clamp(16px, 4vw, 22px) clamp(24px, 5vw, 32px);
  box-shadow: var(--shadow-card);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  position: relative;
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
  box-sizing: border-box;
}

/* ================= 6. TRANG 1 (SECTION 01): BÌA POLAROID & NAMEPLATE ================= */
/* Khối Personal Nameplate: Dời lên trên ảnh Polaroid theo yêu cầu */
.personal-nameplate {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  width: 100%;
  margin-top: 2px;
  margin-bottom: clamp(12px, 2.6vh, 18px);
}

.nameplate-subhead {
  font-family: var(--font-editorial);
  font-style: italic;
  font-size: clamp(16px, 4.4vw, 21px);
  font-weight: 500;
  color: var(--pink-accent);
  letter-spacing: 0.02em;
  line-height: 1.25;
  margin-bottom: 5px;
}

.nameplate-fullname {
  font-family: var(--font-editorial);
  font-size: clamp(26px, 7vw, 34px);
  font-weight: 800;
  letter-spacing: 0.02em;
  line-height: 1.15;
  color: var(--text-dark);
  text-transform: uppercase;
  margin-bottom: 5px;
}

.nameplate-major {
  font-family: var(--font-editorial);
  font-size: clamp(12px, 3.2vw, 14px);
  font-weight: 700;
  letter-spacing: 0.18em;
  color: var(--text-muted);
  text-transform: uppercase;
  line-height: 1.2;
}

/* Ảnh Polaroid lớn căn giữa khung hình, đúng tỷ lệ, đầy đủ mũ và áo */
.polaroid-wrapper {
  position: relative;
  width: 100%;
  max-width: clamp(250px, 68vw, 290px);
  margin: 0 auto clamp(14px, 2.5vh, 20px);
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
  padding: 10px 10px clamp(14px, 3.2vw, 18px);
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
  object-position: center center;
  display: block;
}

.polaroid-caption {
  width: 100%;
  padding-top: 12px;
  padding-bottom: 2px;
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
}

.polaroid-caption-text {
  font-family: var(--font-editorial);
  font-style: italic;
  font-size: clamp(15px, 4vw, 18.5px);
  font-weight: 500;
  color: var(--pink-accent);
  letter-spacing: 0.025em;
  line-height: 1.35;
  white-space: nowrap;
}

/* ================= 7. TRANG 2 (SECTION 02): DẢI PHIM 35MM HÀNH TRÌNH OU ================= */
.film-header {
  margin-bottom: 16px;
  width: 100%;
}

.film-header-badge {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  background: var(--pink-pastel);
  color: var(--pink-accent);
  padding: 4px 14px;
  border-radius: 999px;
  font-family: var(--font-editorial);
  font-size: clamp(10.5px, 2.7vw, 12px);
  font-weight: 700;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  margin-bottom: 10px;
  border: 1px solid var(--pink-border);
}

.film-header-icon {
  font-size: 13px;
}

.film-main-title {
  font-family: var(--font-editorial);
  font-size: clamp(19px, 4.8vw, 24px);
  font-weight: 800;
  color: var(--text-dark);
  letter-spacing: 0.02em;
  line-height: 1.3;
  margin-bottom: 8px;
}

.film-sub-text {
  font-family: var(--font-editorial);
  font-style: italic;
  font-size: clamp(13px, 3.4vw, 14.5px);
  color: var(--text-muted);
  line-height: 1.55;
  max-width: 90%;
  margin: 0 auto;
}

/* Thẻ bao bọc dải phim vintage 35mm */
.film-strip-card {
  width: 100%;
  background: #FFFFFF;
  border-radius: 16px;
  padding: 14px 10px 16px;
  box-shadow: 0 10px 28px -6px rgba(120, 20, 60, 0.12);
  border: 1px solid rgba(240, 180, 200, 0.4);
  position: relative;
  margin-bottom: 18px;
}

.film-washi-tape {
  position: absolute;
  top: -9px;
  left: 50%;
  transform: translateX(-50%) rotate(-1.5deg);
  width: 90px;
  height: 20px;
  background: var(--washi-bg);
  border-radius: 2px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
  backdrop-filter: blur(2px);
  z-index: 5;
}

/* Hộp cuộn dải phim màu đen phong cách cổ điển */
.film-35mm-reel {
  width: 100%;
  background: #181416;
  border-radius: 10px;
  padding: 10px 0;
  overflow: hidden;
  box-shadow: inset 0 2px 10px rgba(0, 0, 0, 0.6), 0 4px 12px rgba(0, 0, 0, 0.2);
  display: flex;
  flex-direction: column;
}

/* Hàng lỗ perforation phía trên và dưới */
.film-perforation-bar {
  display: flex;
  flex-direction: column;
  gap: 4px;
  padding: 0 10px;
}

.bar-top {
  margin-bottom: 8px;
}

.bar-bottom {
  margin-top: 8px;
}

.sprocket-holes {
  width: 100%;
  height: 9px;
  background-image: radial-gradient(circle, #FFFDF9 36%, transparent 40%);
  background-size: 16px 9px;
  background-repeat: repeat-x;
  opacity: 0.88;
}

/* Thông số phim: QUẢN LÝ CÔNG, GRADUATION, OU · 2022-2026 */
.film-meta-text {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-family: var(--font-film-meta) !important;
  font-size: 9.5px;
  color: #FFAEC5;
  letter-spacing: 0.14em;
  font-weight: 700;
  text-transform: uppercase;
  padding: 0 4px;
}

.bar-bottom .film-meta-text {
  color: #FFCCD9;
  letter-spacing: 0.12em;
}

/* Khung nhìn dải phim chạy ngang tự động */
.film-marquee-viewport {
  width: 100%;
  overflow: hidden;
  position: relative;
  mask-image: linear-gradient(90deg, transparent 0%, #000 6%, #000 94%, transparent 100%);
  -webkit-mask-image: linear-gradient(90deg, transparent 0%, #000 6%, #000 94%, transparent 100%);
}

.film-marquee-track {
  display: flex;
  align-items: center;
  gap: 12px;
  width: max-content;
  animation: rollFilmStrip 55s linear infinite;
  will-change: transform;
}

.film-marquee-track:hover {
  animation-play-state: paused;
}

@keyframes rollFilmStrip {
  0% { transform: translateX(0); }
  100% { transform: translateX(-50%); }
}

/* Khung từng bức ảnh trong dải phim */
.film-frame-item {
  height: 185px;
  background: #251E22;
  border-radius: 4px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.4);
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 1px solid rgba(255, 255, 255, 0.1);
  transition: transform 0.3s ease;
}

.film-frame-item:hover {
  transform: scale(1.03);
}

.film-frame-item.is-landscape {
  width: 250px;
}

.film-frame-item.is-landscape-wide {
  width: 280px;
}

.film-frame-item.is-portrait {
  width: 140px;
}

.film-frame-item.is-portrait-23 {
  width: 125px;
}

.film-frame-item.is-square {
  width: 185px;
}

.film-photo {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: center center;
  display: block;
}

/* ================= 8. TRANG 3 (SECTION 03): THƯ MỜI THÂN THƯƠNG TỪ TÚ ================= */
.letter-scrapbook-card {
  width: 100%;
  background: #FFFDFB;
  border-radius: 16px;
  padding: clamp(24px, 5vw, 32px) clamp(16px, 4vw, 24px) clamp(20px, 4.5vw, 28px);
  border: 1px solid rgba(235, 195, 210, 0.5);
  box-shadow: 0 10px 30px -8px rgba(140, 30, 70, 0.12);
  position: relative;
  text-align: left;
  margin-bottom: 18px;
}

.letter-washi {
  position: absolute;
  top: -9px;
  right: 28px;
  width: 70px;
  height: 18px;
  background: var(--washi-bg);
  transform: rotate(3deg);
  border-radius: 2px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.04);
}

/* Con dấu sáp niêm phong thư vintage */
.wax-seal-stamp {
  position: absolute;
  top: 18px;
  right: 18px;
  width: 44px;
  height: 44px;
  border-radius: 50%;
  background: radial-gradient(circle, #D82658 0%, #A6143E 75%, #7D0B2B 100%);
  box-shadow: 0 4px 12px rgba(160, 20, 60, 0.35), inset 0 2px 4px rgba(255, 255, 255, 0.3);
  display: flex;
  align-items: center;
  justify-content: center;
  border: 2px solid #E84D78;
}

.wax-seal-inner {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: #FFF2F6;
  font-family: var(--font-editorial);
  font-weight: 800;
  line-height: 1;
}

.seal-school {
  font-size: 13px;
  letter-spacing: 0.05em;
}

.seal-year {
  font-size: 9px;
  letter-spacing: 0.05em;
  opacity: 0.9;
}

.letter-header {
  margin-bottom: 16px;
  padding-right: 50px;
}

.letter-place-date {
  font-family: var(--font-editorial);
  font-style: italic;
  font-size: clamp(11.5px, 2.9vw, 13px);
  color: var(--text-muted);
  margin-bottom: 8px;
}

.letter-salutation {
  font-family: var(--font-editorial);
  font-size: clamp(19px, 5vw, 23px);
  font-weight: 700;
  color: var(--pink-accent);
  line-height: 1.3;
}

.letter-content {
  display: flex;
  flex-direction: column;
  gap: 12px;
  font-family: var(--font-editorial);
  font-size: clamp(14px, 3.6vw, 15.5px);
  color: var(--text-dark);
  line-height: 1.7;
}

.letter-paragraph.highlight-msg {
  font-style: italic;
  color: #B51E4E;
  background: var(--pink-pastel-light);
  padding: 10px 14px;
  border-radius: 8px;
  border-left: 3px solid var(--pink-accent);
}

.letter-footer {
  margin-top: 18px;
  text-align: right;
}

.letter-sign-close {
  font-family: var(--font-editorial);
  font-style: italic;
  font-size: clamp(12.5px, 3vw, 14px);
  color: var(--text-muted);
  margin-bottom: 2px;
}

.letter-signature {
  font-family: var(--font-editorial);
  font-style: italic;
  font-size: clamp(21px, 5.5vw, 26px);
  font-weight: 700;
  color: var(--pink-accent);
}

/* ================= 9. TRANG 4 (SECTION 04): CHI TIẾT LỄ TỐT NGHIỆP ================= */
.details-header {
  margin-bottom: 16px;
  width: 100%;
}

.details-badge {
  display: inline-block;
  background: var(--pink-pastel);
  color: var(--pink-accent);
  padding: 4px 14px;
  border-radius: 999px;
  font-family: var(--font-editorial);
  font-size: clamp(10px, 2.6vw, 11.5px);
  font-weight: 700;
  letter-spacing: 0.1em;
  margin-bottom: 8px;
  border: 1px solid var(--pink-border);
}

.details-main-title {
  font-family: var(--font-editorial);
  font-size: clamp(20px, 5.2vw, 25px);
  font-weight: 800;
  color: var(--text-dark);
  letter-spacing: 0.02em;
  line-height: 1.25;
  margin-bottom: 4px;
}

.details-sub-tag {
  font-family: var(--font-editorial);
  font-size: clamp(11.5px, 2.8vw, 13px);
  font-weight: 600;
  color: var(--text-muted);
  letter-spacing: 0.08em;
}

.ceremony-info-card {
  width: 100%;
  background: #FFFFFF;
  border-radius: 16px;
  padding: clamp(18px, 4vw, 24px) clamp(14px, 3.5vw, 20px);
  box-shadow: 0 10px 28px -6px rgba(120, 20, 60, 0.12);
  border: 1px solid rgba(240, 180, 200, 0.4);
  display: flex;
  flex-direction: column;
  gap: 14px;
  text-align: left;
  margin-bottom: 18px;
}

.info-item-row {
  display: flex;
  gap: 12px;
  align-items: flex-start;
}

.info-item-row.highlight-box {
  background: var(--pink-pastel-light);
  padding: 12px 14px;
  border-radius: 12px;
  border: 1.5px solid rgba(232, 39, 94, 0.25);
}

.info-row-icon {
  font-size: 18px;
  flex-shrink: 0;
  margin-top: 2px;
}

.info-row-text {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.info-row-label {
  font-family: var(--font-editorial);
  font-size: clamp(11px, 2.7vw, 12.5px);
  font-weight: 600;
  color: var(--text-muted);
  text-transform: uppercase;
  letter-spacing: 0.04em;
}

.info-row-value {
  font-family: var(--font-editorial);
  font-size: clamp(14px, 3.7vw, 16px);
  font-weight: 700;
  color: var(--text-dark);
  line-height: 1.4;
}

.info-row-value.photo-time {
  font-size: clamp(17px, 4.4vw, 20px);
  color: var(--pink-accent);
  font-weight: 800;
}

.info-row-desc {
  font-family: var(--font-editorial);
  font-style: italic;
  font-size: clamp(12px, 3vw, 13.5px);
  color: var(--text-muted);
  line-height: 1.45;
  margin-top: 2px;
}

.parking-list {
  list-style: none;
  margin-top: 4px;
  display: flex;
  flex-direction: column;
  gap: 3px;
  font-family: var(--font-editorial);
  font-size: clamp(12.5px, 3.2vw, 14px);
  color: var(--text-dark);
}

.details-action-wrap {
  margin-top: 6px;
  width: 100%;
}

.btn-maps-action {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  width: 100%;
  background: linear-gradient(135deg, #FF6B93 0%, #E8275E 100%);
  color: #FFFFFF;
  text-decoration: none;
  font-family: var(--font-editorial);
  font-size: clamp(13px, 3.4vw, 15px);
  font-weight: 700;
  padding: 11px 16px;
  border-radius: 999px;
  box-shadow: 0 6px 18px rgba(232, 39, 94, 0.32);
  transition: all 0.3s cubic-bezier(0.2, 0.8, 0.2, 1);
}

.btn-maps-action:active {
  transform: scale(0.97);
}

/* ================= 10. NÚT ĐIỀU HƯỚNG LẬT TRANG (PAGE ACTION BUTTONS) ================= */
.page-action-row {
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-top: 2px;
}

.page-action-row.dual-action {
  justify-content: space-between;
  gap: 12px;
}

.btn-flip-page {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  background: #FFFFFF;
  color: var(--pink-accent);
  border: 1.5px solid var(--pink-border);
  border-radius: 999px;
  padding: 9px 18px;
  font-family: var(--font-editorial);
  font-size: clamp(13px, 3.4vw, 14.5px);
  font-weight: 700;
  cursor: pointer;
  box-shadow: 0 4px 12px rgba(180, 45, 90, 0.08);
  transition: all 0.25s cubic-bezier(0.2, 0.8, 0.2, 1);
}

.btn-flip-page:hover {
  background: var(--pink-pastel-light);
  border-color: var(--pink-accent);
  transform: translateY(-1px);
  box-shadow: 0 6px 16px rgba(232, 39, 94, 0.18);
}

.btn-flip-page:active {
  transform: scale(0.96);
}

.btn-flip-page.btn-next {
  background: linear-gradient(135deg, #FFF0F6 0%, #FFE2ED 100%);
  border-color: rgba(232, 39, 94, 0.35);
}

.flip-btn-icon {
  font-size: 13px;
}

/* Nếp gấp lật góc sách 3D (Corner Page Curl) */
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

/* ================= 11. NÚT ĐIỀU KHIỂN ÂM THANH NỀN TINH TẾ (GÓC TRÊN PHẢI) ================= */
.btn-sound-control {
  position: fixed;
  top: 14px;
  right: 14px;
  z-index: 9999;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.92);
  border: 1.5px solid rgba(232, 39, 94, 0.35);
  box-shadow: 0 4px 16px rgba(180, 45, 90, 0.16), 0 2px 6px rgba(0, 0, 0, 0.04);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.25s cubic-bezier(0.2, 0.8, 0.2, 1);
  color: var(--pink-accent);
  user-select: none;
}

.btn-sound-control:hover {
  transform: scale(1.08);
  box-shadow: 0 6px 20px rgba(232, 39, 94, 0.28);
  border-color: var(--pink-accent);
}

.btn-sound-control:active {
  transform: scale(0.92);
}

.sound-icon {
  font-size: 17px;
  line-height: 1;
  display: inline-block;
  transition: transform 0.2s ease, opacity 0.2s ease;
}

.btn-sound-control.is-playing .sound-icon {
  animation: soundPulse 1.8s infinite ease-in-out;
}

.btn-sound-control.is-muted {
  background: rgba(255, 255, 255, 0.78);
  border-color: rgba(160, 140, 150, 0.35);
  color: var(--text-muted);
}

.btn-sound-control.is-muted .sound-icon {
  opacity: 0.6;
  animation: none;
}

@keyframes soundPulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.18); }
}
'@

$outPath = "$PSScriptRoot\..\style.css"
[System.IO.File]::WriteAllText($outPath, $cssContent, [System.Text.Encoding]::UTF8)
Write-Host "Updated style.css v3 successfully!"
