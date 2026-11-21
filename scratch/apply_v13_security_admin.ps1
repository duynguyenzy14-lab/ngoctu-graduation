# apply_v13_security_admin.ps1
$ErrorActionPreference = "Stop"

# -------------------------------------------------------------
# 1. Update index.html
# -------------------------------------------------------------
$html = Get-Content -Path "index.html" -Raw -Encoding UTF8

# Add secret trigger ID to icon
$targetHeader = '<div class="wishes-board-header">'
$replaceHeader = '<div class="wishes-board-header" id="wishesBoardHeader"><span class="wishes-icon" id="wishesSecretTrigger" title="Nhấn 3 lần để mở quản lý bí mật">💌</span><span class="wishes-title">Lời chúc từ những người thương</span></div>'
$html = $html -replace '(?s)<div class="wishes-board-header">[\s\S]*?</div>', $replaceHeader

# Add Admin Modal before </body> if not present
if ($html -notmatch 'id="adminModalOverlay"') {
  $adminModalHtml = @"

  <!-- ================= BẢNG QUẢN TRỊ BÍ MẬT DÀNH RIÊNG CHO NGỌC TÚ (CHỐNG HATERS) ================= -->
  <div class="admin-modal-overlay" id="adminModalOverlay" hidden>
    <div class="admin-modal-card">
      <div class="admin-modal-header">
        <h3 class="admin-modal-title">🔐 Quản trị Sổ lưu bút (Ngọc Tú)</h3>
        <button type="button" class="btn-close-admin" id="btnCloseAdmin" aria-label="Đóng">&times;</button>
      </div>

      <!-- Màn hình 1: Nhập mã PIN bảo mật -->
      <div id="adminPinScreen" class="admin-screen">
        <p class="admin-desc">Nhập mã PIN bí mật của bạn để quản lý lời chúc (chỉ mình bạn có quyền sửa/xóa):</p>
        <div class="pin-input-wrap">
          <input type="password" id="adminPinInput" class="admin-input" maxlength="8" placeholder="Mã PIN (mặc định: 2811)">
          <button type="button" class="btn-admin-primary" id="btnVerifyPin">Mở khóa</button>
        </div>
        <p class="admin-error-text" id="adminPinError" hidden>Mã PIN không đúng, vui lòng thử lại!</p>
      </div>

      <!-- Màn hình 2: Bảng điều khiển quản lý lời chúc -->
      <div id="adminDashboardScreen" class="admin-screen" hidden>
        <div class="admin-top-bar">
          <span class="admin-stat-text" id="adminWishesCount">0 lời chúc</span>
          <div class="admin-bar-btns">
            <button type="button" class="btn-admin-add" id="btnOpenAddWish">+ Thêm lời chúc</button>
            <button type="button" class="btn-admin-pin-change" id="btnChangePin">Đổi PIN</button>
          </div>
        </div>

        <!-- Form thêm lời chúc thủ công của Tú -->
        <div id="adminAddWishForm" class="admin-sub-card" hidden>
          <p class="admin-sub-title">Thêm lời chúc mới:</p>
          <input type="text" id="adminNewName" class="admin-input" placeholder="Tên người chúc...">
          <textarea id="adminNewMsg" class="admin-textarea" rows="2" placeholder="Nội dung lời chúc..."></textarea>
          <div class="admin-form-btns">
            <button type="button" class="btn-admin-primary" id="btnSaveNewWish">Lưu lời chúc</button>
            <button type="button" class="btn-admin-cancel" id="btnCancelAddWish">Hủy</button>
          </div>
        </div>

        <!-- Danh sách quản lý lời chúc (kèm nút xóa) -->
        <div class="admin-wishes-manager" id="adminWishesManager">
          <!-- Render danh sách lời chúc kèm nút xóa/ẩn -->
        </div>
      </div>

    </div>
  </div>
"@
  $html = $html.Replace("</body>", "$adminModalHtml`n</body>")
}

[System.IO.File]::WriteAllText("$PSScriptRoot\..\index.html", $html, [System.Text.Encoding]::UTF8)
Write-Host "Updated index.html with Admin Modal successfully!"

# -------------------------------------------------------------
# 2. Update style.css
# -------------------------------------------------------------
$css = Get-Content -Path "style.css" -Raw -Encoding UTF8

if ($css -notmatch '\.admin-modal-overlay') {
  $adminCss = @"

/* ================= 13. MODAL QUẢN TRỊ BÍ MẬT DÀNH RIÊNG CHO NGỌC TÚ ================= */
.admin-modal-overlay {
  position: fixed;
  inset: 0;
  background: rgba(30, 15, 22, 0.65);
  z-index: 99999;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 16px;
  backdrop-filter: blur(5px);
  -webkit-backdrop-filter: blur(5px);
}

.admin-modal-card {
  background: #FFFFFF;
  border-radius: 16px;
  max-width: 390px;
  width: 100%;
  max-height: 82vh;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  box-shadow: 0 16px 40px rgba(0, 0, 0, 0.28);
  border: 1px solid rgba(232, 39, 94, 0.2);
}

.admin-modal-header {
  padding: 13px 16px;
  background: #FFF0F6;
  border-bottom: 1px solid rgba(232, 39, 94, 0.15);
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.admin-modal-title {
  font-family: var(--font-editorial);
  font-size: 14.5px;
  font-weight: 700;
  color: #B51E4E;
  margin: 0;
}

.btn-close-admin {
  background: none;
  border: none;
  font-size: 24px;
  line-height: 1;
  color: #8A6572;
  cursor: pointer;
  padding: 0;
}

.admin-screen {
  padding: 16px;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.admin-desc {
  font-family: var(--font-editorial);
  font-size: 13px;
  color: #4A3A40;
  line-height: 1.5;
  margin: 0;
}

.pin-input-wrap {
  display: flex;
  gap: 8px;
  margin-top: 4px;
}

.admin-input,
.admin-textarea {
  font-family: var(--font-editorial);
  font-size: 13.5px;
  padding: 9px 12px;
  border: 1.5px solid rgba(232, 39, 94, 0.25);
  border-radius: 8px;
  background: #FFF9FB;
  width: 100%;
  box-sizing: border-box;
  outline: none;
}

.admin-input:focus,
.admin-textarea:focus {
  border-color: var(--pink-accent);
  background: #FFFFFF;
}

.btn-admin-primary {
  padding: 9px 16px;
  background: linear-gradient(135deg, #FF6B93 0%, #E8275E 100%);
  color: #FFFFFF;
  border: none;
  border-radius: 8px;
  font-family: var(--font-editorial);
  font-size: 13px;
  font-weight: 700;
  cursor: pointer;
  white-space: nowrap;
}

.admin-error-text {
  font-family: var(--font-editorial);
  font-size: 12.5px;
  color: #D4144B;
  margin: 0;
}

.admin-top-bar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-bottom: 8px;
  border-bottom: 1px dashed rgba(232, 39, 94, 0.2);
}

.admin-stat-text {
  font-family: var(--font-editorial);
  font-size: 13px;
  font-weight: 700;
  color: #B51E4E;
}

.admin-bar-btns {
  display: flex;
  gap: 6px;
}

.btn-admin-add {
  padding: 6px 11px;
  background: #FFF0F6;
  border: 1px solid rgba(232, 39, 94, 0.3);
  color: #B51E4E;
  border-radius: 6px;
  font-family: var(--font-editorial);
  font-size: 12px;
  font-weight: 700;
  cursor: pointer;
}

.btn-admin-pin-change {
  padding: 6px 9px;
  background: #F5F5F5;
  border: 1px solid #DDD;
  color: #555;
  border-radius: 6px;
  font-family: var(--font-editorial);
  font-size: 11.5px;
  cursor: pointer;
}

.admin-sub-card {
  background: #FFF5F8;
  border: 1px solid rgba(232, 39, 94, 0.2);
  border-radius: 10px;
  padding: 12px;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.admin-sub-title {
  font-family: var(--font-editorial);
  font-size: 12.5px;
  font-weight: 700;
  color: #B51E4E;
  margin: 0;
}

.admin-form-btns {
  display: flex;
  gap: 8px;
  justify-content: flex-end;
}

.btn-admin-cancel {
  padding: 8px 14px;
  background: #EEEEEE;
  border: none;
  border-radius: 8px;
  font-family: var(--font-editorial);
  font-size: 12.5px;
  cursor: pointer;
}

.admin-wishes-manager {
  display: flex;
  flex-direction: column;
  gap: 8px;
  max-height: 280px;
  overflow-y: auto;
  padding-right: 2px;
}

.admin-wish-card {
  background: #FFF9FB;
  border: 1px solid rgba(232, 39, 94, 0.15);
  border-radius: 8px;
  padding: 8px 10px;
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 8px;
}

.admin-wish-info {
  display: flex;
  flex-direction: column;
  gap: 2px;
  flex: 1;
}

.admin-wish-name {
  font-family: var(--font-editorial);
  font-size: 12.5px;
  font-weight: 700;
  color: #2B2125;
}

.admin-wish-msg {
  font-family: var(--font-editorial);
  font-size: 12px;
  color: #5A4A52;
  margin: 0;
  line-height: 1.4;
}

.btn-admin-delete {
  padding: 4px 8px;
  background: #FFF0F2;
  border: 1px solid #F5A8B8;
  color: #D4144B;
  border-radius: 6px;
  font-size: 11px;
  font-weight: 700;
  cursor: pointer;
  flex-shrink: 0;
}
"@
  $css += "`n`n" + $adminCss
  [System.IO.File]::WriteAllText("$PSScriptRoot\..\style.css", $css, [System.Text.Encoding]::UTF8)
  Write-Host "Updated style.css with Admin styles!"
}

# -------------------------------------------------------------
# 3. Update script.js
# -------------------------------------------------------------
$js = Get-Content -Path "script.js" -Raw -Encoding UTF8

# Add Admin Panel Logic and Secret Triple-Tap Trigger
if ($js -notmatch 'initAdminPanel') {
  $adminJsLogic = @'

// ================= 6. HỆ THỐNG BẢO MẬT & QUẢN TRỊ BÍ MẬT DÀNH RIÊNG CHO NGỌC TÚ =================
const ADMIN_PIN_KEY = "ngoctu_admin_pin";
const DEFAULT_PIN = "2811"; // Mã PIN mặc định: ngày 28.11 của Tú

function getAdminPin() {
  return localStorage.getItem(ADMIN_PIN_KEY) || DEFAULT_PIN;
}

function initAdminPanel() {
  const triggerBtn = document.getElementById("wishesSecretTrigger");
  const modalOverlay = document.getElementById("adminModalOverlay");
  const btnClose = document.getElementById("btnCloseAdmin");
  const btnVerify = document.getElementById("btnVerifyPin");
  const pinInput = document.getElementById("adminPinInput");
  const pinError = document.getElementById("adminPinError");

  const pinScreen = document.getElementById("adminPinScreen");
  const dashScreen = document.getElementById("adminDashboardScreen");

  const btnOpenAdd = document.getElementById("btnOpenAddWish");
  const addForm = document.getElementById("adminAddWishForm");
  const btnSaveWish = document.getElementById("btnSaveNewWish");
  const btnCancelAdd = document.getElementById("btnCancelAddWish");
  const btnChangePin = document.getElementById("btnChangePin");

  // 1. Chạm 3 lần vào icon 💌 để mở Bảng Quản Trị Bí Mật
  let tapCount = 0;
  let tapTimer = null;
  if (triggerBtn) {
    triggerBtn.style.cursor = "pointer";
    triggerBtn.addEventListener("click", (e) => {
      e.stopPropagation();
      tapCount++;
      if (tapCount === 1) {
        tapTimer = setTimeout(() => { tapCount = 0; }, 900);
      } else if (tapCount >= 3) {
        clearTimeout(tapTimer);
        tapCount = 0;
        openAdminModal();
      }
    });
  }

  function openAdminModal() {
    if (!modalOverlay) return;
    modalOverlay.hidden = false;
    pinScreen.hidden = false;
    dashScreen.hidden = true;
    if (pinError) pinError.hidden = true;
    if (pinInput) {
      pinInput.value = "";
      setTimeout(() => pinInput.focus(), 150);
    }
  }

  function closeAdminModal() {
    if (modalOverlay) modalOverlay.hidden = true;
  }

  if (btnClose) btnClose.addEventListener("click", closeAdminModal);
  if (modalOverlay) {
    modalOverlay.addEventListener("click", (e) => {
      if (e.target === modalOverlay) closeAdminModal();
    });
  }

  // 2. Xác thực mã PIN
  if (btnVerify && pinInput) {
    btnVerify.addEventListener("click", verifyPin);
    pinInput.addEventListener("keydown", (e) => {
      if (e.key === "Enter") verifyPin();
    });
  }

  function verifyPin() {
    const entered = pinInput.value.trim();
    if (entered === getAdminPin()) {
      if (pinError) pinError.hidden = true;
      pinScreen.hidden = true;
      dashScreen.hidden = false;
      renderAdminWishes();
    } else {
      if (pinError) pinError.hidden = false;
      pinInput.value = "";
      pinInput.focus();
    }
  }

  // 3. Render danh sách lời chúc trong Admin Dashboard
  function renderAdminWishes() {
    const listContainer = document.getElementById("adminWishesManager");
    const countEl = document.getElementById("adminWishesCount");
    const wishes = getStoredWishes();

    if (countEl) countEl.textContent = `${wishes.length} lời chúc hiện tại`;
    if (!listContainer) return;

    if (wishes.length === 0) {
      listContainer.innerHTML = '<p class="admin-desc" style="text-align:center; padding:12px;">Chưa có lời chúc nào trong danh sách.</p>';
      return;
    }

    listContainer.innerHTML = wishes.map((w, idx) => `
      <div class="admin-wish-card">
        <div class="admin-wish-info">
          <span class="admin-wish-name">✨ ${escapeHtml(w.name)}</span>
          <p class="admin-wish-msg">“${escapeHtml(w.message)}”</p>
        </div>
        <button type="button" class="btn-admin-delete" data-del-idx="${idx}">🗑️ Xóa</button>
      </div>
    `).join("");

    listContainer.querySelectorAll("[data-del-idx]").forEach(btn => {
      btn.addEventListener("click", () => {
        const idx = parseInt(btn.getAttribute("data-del-idx"), 10);
        if (!isNaN(idx) && confirm(`Xóa lời chúc của "${wishes[idx].name}" khỏi website?`)) {
          wishes.splice(idx, 1);
          saveAndSyncWishes(wishes);
          renderAdminWishes();
          renderWishesList(wishes);
        }
      });
    });
  }

  // 4. Thêm lời chúc thủ công của Tú
  if (btnOpenAdd && addForm) {
    btnOpenAdd.addEventListener("click", () => {
      addForm.hidden = false;
      document.getElementById("adminNewName")?.focus();
    });
  }
  if (btnCancelAdd && addForm) {
    btnCancelAdd.addEventListener("click", () => {
      addForm.hidden = true;
    });
  }
  if (btnSaveWish) {
    btnSaveWish.addEventListener("click", () => {
      const nameInput = document.getElementById("adminNewName");
      const msgInput = document.getElementById("adminNewMsg");
      const name = nameInput ? nameInput.value.trim() : "";
      const msg = msgInput ? msgInput.value.trim() : "";

      if (!name || !msg) {
        alert("Vui lòng nhập đầy đủ tên và lời chúc nha Tú!");
        return;
      }

      const newWish = {
        name: name,
        attending: "Sẽ đến nhaa!",
        message: msg,
        time: "Vừa xong",
        isNew: true
      };

      let wishes = getStoredWishes();
      wishes = [newWish, ...wishes];
      saveAndSyncWishes(wishes);
      renderAdminWishes();
      renderWishesList(wishes);

      if (nameInput) nameInput.value = "";
      if (msgInput) msgInput.value = "";
      if (addForm) addForm.hidden = true;
    });
  }

  // 5. Đổi mã PIN bí mật
  if (btnChangePin) {
    btnChangePin.addEventListener("click", () => {
      const newPin = prompt("Nhập mã PIN mới của bạn (4-6 ký tự):", getAdminPin());
      if (newPin && newPin.trim().length >= 4) {
        localStorage.setItem(ADMIN_PIN_KEY, newPin.trim());
        alert(`Đã đổi mã PIN thành công! Mã PIN mới của bạn là: ${newPin.trim()}`);
      }
    });
  }
}

// Hàm lưu và đồng bộ danh sách đã kiểm duyệt lên Đám mây
async function saveAndSyncWishes(wishes) {
  try {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(wishes));
  } catch (e) {
    console.error("Lỗi lưu local:", e);
  }

  try {
    const cleanList = wishes.map(w => ({
      name: w.name,
      attending: w.attending || "Sẽ đến nhaa!",
      message: w.message,
      time: w.time || "28/11/2026"
    }));
    await fetch(CLOUD_GUESTBOOK_API, {
      method: "PUT",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        name: "Ngoctu Graduation Guestbook 2026",
        data: { wishes: cleanList }
      })
    });
  } catch (err) {
    console.warn("Lỗi đồng bộ đám mây:", err);
  }
}
'@

  # Thêm vào DOMContentLoaded
  $js = $js -replace 'document\.addEventListener\("DOMContentLoaded", \(\) => \{', "document.addEventListener(`"DOMContentLoaded`", () => {`n  initAdminPanel();"
  $js += "`n" + $adminJsLogic
  [System.IO.File]::WriteAllText("$PSScriptRoot\..\script.js", $js, [System.Text.Encoding]::UTF8)
  Write-Host "Updated script.js with Admin logic!"
}
