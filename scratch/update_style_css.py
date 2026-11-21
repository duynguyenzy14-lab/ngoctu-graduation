# Python script to update style.css with vertical layout, dashed section borders, and unified Playfair Display font
import re

css_path = r"c:\Users\Tu Nguyen\OneDrive\Documents\GitHub\ngoctu-graduation\style.css"

with open(css_path, "r", encoding="utf-8") as f:
    css = f.read()

# 1. Update font variables in :root
css = re.sub(
    r":root\s*\{[\s\S]*?--font-handwrite:[^;]+;",
    """:root {
  /* Typography - Đồng nhất font chữ của "The Graduation Day of" (Playfair Display) cho toàn trang */
  --font-main: 'Playfair Display', Georgia, serif;
  --font-editorial: 'Playfair Display', Georgia, serif;
  --font-handwrite: 'Playfair Display', Georgia, serif;
  --font-film-meta: 'Courier New', Courier, monospace, sans-serif;""",
    css,
    count=1
)

# 2. Update .book-viewport and .book-spread to vertical layout (dọc), mobile optimized
old_viewport_block = r"""\.book-viewport\s*\{[\s\S]*?@keyframes flipInFromLeft\s*\{[\s\S]*?\}\s*\}"""

new_viewport_block = """/* ================= BỐ CỤC ĐỊNH DẠNG DỌC (VERTICAL LAYOUT) TỐI ƯU TRÊN ĐIỆN THOẠI ================= */
.book-viewport {
  width: 100%;
  min-height: 100vh;
  position: relative;
  perspective: 2500px;
  overflow-x: hidden;
}

.book-spread {
  display: none;
  flex-direction: column;
  align-items: center;
  width: 100%;
  max-width: 620px; /* Định dạng dọc chuẩn form thiệp mời sang trọng, tối ưu cho mobile */
  margin: 0 auto;
  position: relative;
  padding: clamp(20px, 4vw, 36px) clamp(14px, 3.5vw, 20px) 100px;
  opacity: 0;
  visibility: hidden;
  pointer-events: none;
  transform-style: preserve-3d;
  transition: opacity 0.4s ease;
  box-sizing: border-box;
}

.book-spread.is-active {
  display: flex;
  opacity: 1;
  visibility: visible;
  pointer-events: auto;
  z-index: 10;
}

/* Hiệu ứng lật trang 3D chân thực như lật sách */
.book-viewport.is-turning-forward .spread-1 {
  animation: flipOutToLeft 0.75s cubic-bezier(0.645, 0.045, 0.355, 1) forwards;
}

.book-viewport.is-turning-forward .spread-2 {
  opacity: 1;
  visibility: visible;
  animation: flipInFromRight 0.75s cubic-bezier(0.645, 0.045, 0.355, 1) forwards;
}

.book-viewport.is-turning-backward .spread-2 {
  animation: flipOutToRight 0.75s cubic-bezier(0.645, 0.045, 0.355, 1) forwards;
}

.book-viewport.is-turning-backward .spread-1 {
  opacity: 1;
  visibility: visible;
  animation: flipInFromLeft 0.75s cubic-bezier(0.645, 0.045, 0.355, 1) forwards;
}

@keyframes flipOutToLeft {
  0% { transform: rotateY(0deg) scale(1); opacity: 1; }
  40% { transform: rotateY(-35deg) scale(0.96); opacity: 0.9; box-shadow: -20px 0 50px rgba(0, 0, 0, 0.2); }
  100% { transform: rotateY(-80deg) scale(0.92); opacity: 0; }
}

@keyframes flipInFromRight {
  0% { transform: rotateY(80deg) scale(0.92); opacity: 0; }
  60% { transform: rotateY(20deg) scale(0.98); opacity: 0.95; }
  100% { transform: rotateY(0deg) scale(1); opacity: 1; }
}

@keyframes flipOutToRight {
  0% { transform: rotateY(0deg) scale(1); opacity: 1; }
  40% { transform: rotateY(35deg) scale(0.96); opacity: 0.9; }
  100% { transform: rotateY(80deg) scale(0.92); opacity: 0; }
}

@keyframes flipInFromLeft {
  0% { transform: rotateY(-80deg) scale(0.92); opacity: 0; }
  60% { transform: rotateY(-20deg) scale(0.98); opacity: 0.95; }
  100% { transform: rotateY(0deg) scale(1); opacity: 1; }
}"""

css = re.sub(old_viewport_block, new_viewport_block, css, count=1)

# 3. Replace section layout, removing ribbon CSS and inserting .sec-card-dashed & .section-dashed-divider
old_middle_block = r"""/\* Các section trong mỗi trang sách[\s\S]*?/\* ================= POLAROID PORTRAIT"""

new_middle_block = """/* ================= MỖI SECTION LÀ ĐƯỜNG LINE ĐỨT SCRAPBOOK ĐIỆU ĐÀ ================= */
.sec-card-dashed {
  width: 100%;
  background: rgba(255, 255, 255, 0.88);
  border: 2px dashed rgba(232, 39, 94, 0.38) !important;
  border-radius: clamp(22px, 4.5vw, 28px);
  padding: clamp(24px, 4.5vw, 34px) clamp(16px, 3.5vw, 24px);
  box-shadow: 0 12px 32px -8px rgba(220, 60, 110, 0.1), 0 3px 10px rgba(0, 0, 0, 0.02);
  backdrop-filter: blur(8px);
  position: relative;
  box-sizing: border-box;
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
  margin: 0 0 4px;
}

/* Đường line đứt điệu đà ngăn cách giữa 2 section */
.section-dashed-divider {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  max-width: 260px;
  margin: 18px auto;
  gap: 14px;
}

.section-dashed-divider .divider-line {
  flex: 1;
  border-bottom: 2px dashed rgba(232, 39, 94, 0.38);
  height: 0;
}

.section-dashed-divider .divider-heart {
  color: var(--pink-accent);
  font-size: 16px;
  line-height: 1;
  animation: heartPulse 2.4s infinite ease-in-out;
}

@keyframes heartPulse {
  0%, 100% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.22);
  }
}

.sec-left, .sec-right {
  position: relative;
  box-sizing: border-box;
  border-right: none !important;
}

.sec-left-inner, .sec-right-inner {
  width: 100%;
  max-width: 520px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
}

/* ================= POLAROID PORTRAIT"""

css = re.sub(old_middle_block, new_middle_block, css, count=1)

with open(css_path, "w", encoding="utf-8") as f:
    f.write(css)

print("Updated style.css successfully!")
