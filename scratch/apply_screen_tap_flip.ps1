# apply_screen_tap_flip.ps1
$ErrorActionPreference = "Stop"

$js = Get-Content -Path "script.js" -Raw -Encoding UTF8

$targetSwipeSection = @"
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

    if (Math.abs(deltaX) > 48 && Math.abs(deltaX) > Math.abs(deltaY) * 1.5) {
      if (deltaX < 0) {
        flipToPage(currentPage + 1);
      } else {
        flipToPage(currentPage - 1);
      }
    }
  }
}
"@

$replaceSwipeSection = @"
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
"@

if ($js.Contains($targetSwipeSection)) {
  $js = $js.Replace($targetSwipeSection, $replaceSwipeSection)
  Write-Host "Replaced touch/swipe section with screen tap flip logic!"
} else {
  Write-Host "Target swipe section not found directly, using regex replace" -ForegroundColor Yellow
  $regex = '(?s)let touchStartX = 0;[\s\S]*?handleTouchSwipe\(\);\s*\}\s*\}\s*\}'
  $js = [System.Text.RegularExpressions.Regex]::Replace($js, $regex, $replaceSwipeSection.Trim())
}

[System.IO.File]::WriteAllText("$PSScriptRoot\..\script.js", $js, [System.Text.Encoding]::UTF8)
Write-Host "Updated script.js successfully!"
