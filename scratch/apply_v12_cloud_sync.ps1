# apply_v12_cloud_sync.ps1
$ErrorActionPreference = "Stop"

$js = Get-Content -Path "script.js" -Raw -Encoding UTF8

# Update section 4 in script.js to add cloud sync
$targetSection4Regex = '(?s)// =+\s*4\.\s*QUẢN LÝ SỔ LƯU BÚT[\s\S]*?function escapeHtml\(str\) \{'
$newSection4 = @'
// ================= 4. QUẢN LÝ SỔ LƯU BÚT ĐỒNG BỘ ĐÁM MÂY (CLOUD SYNC) & TỰ ĐỘNG CUỘN DỌC =================
const STORAGE_KEY = "ngoctu_graduation_wishes_v2";
const CLOUD_GUESTBOOK_API = "https://api.restful-api.dev/objects/ff808181a09d98f701a1fe4fe584112c";

function getStoredWishes() {
  try {
    const raw = localStorage.getItem(STORAGE_KEY);
    if (raw) {
      const parsed = JSON.parse(raw);
      if (Array.isArray(parsed)) {
        return parsed.filter(w => !isContentInappropriate(w.name + " " + w.message));
      }
    }
  } catch (e) {
    console.error("Lỗi đọc lời chúc:", e);
  }
  return DEFAULT_WISHES;
}

async function fetchCloudWishes() {
  try {
    const res = await fetch(CLOUD_GUESTBOOK_API);
    if (res.ok) {
      const data = await res.json();
      if (data && data.data && Array.isArray(data.data.wishes)) {
        const cloudWishes = data.data.wishes.filter(w => !isContentInappropriate(w.name + " " + w.message));
        localStorage.setItem(STORAGE_KEY, JSON.stringify(cloudWishes));
        renderWishesList(cloudWishes);
      }
    }
  } catch (err) {
    console.warn("Không thể tải lời chúc từ đám mây (dùng cache local):", err);
  }
}

function renderWishesList(wishes) {
  const container = document.getElementById("wishesList");
  if (!container) return;

  // Nếu chưa có lời chúc nào: hiển thị ô trống dịu dàng
  if (!wishes || wishes.length === 0) {
    container.classList.remove("is-scrolling");
    container.innerHTML = `
      <div class="wishes-empty-state">
        <span class="empty-icon">💌</span>
        <p class="empty-text">Chưa có lời chúc nào nè.<br>Hãy là người đầu tiên gửi lời chúc đến Ngọc Tú nhé! ♡</p>
      </div>
    `;
    return;
  }

  // Nếu chỉ có 1 lời chúc: hiển thị tĩnh không cần cuộn
  if (wishes.length === 1) {
    container.classList.remove("is-scrolling");
    const item = wishes[0];
    container.innerHTML = `
      <div class="wish-item ${item.isNew ? 'is-new' : ''}">
        <div class="wish-meta">
          <span class="wish-author">✨ ${escapeHtml(item.name)}</span>
          <span class="wish-tag">${escapeHtml(item.attending || "Sẽ đến nhaa!")}</span>
        </div>
        <p class="wish-content">“${escapeHtml(item.message)}”</p>
      </div>
    `;
    return;
  }

  // Nếu có từ 2 lời chúc trở lên: tự động cuộn dọc (Vertical Marquee)
  const itemsHtml = wishes.map((item) => `
    <div class="wish-item ${item.isNew ? 'is-new' : ''}">
      <div class="wish-meta">
        <span class="wish-author">✨ ${escapeHtml(item.name)}</span>
        <span class="wish-tag">${escapeHtml(item.attending || "Sẽ đến nhaa!")}</span>
      </div>
      <p class="wish-content">“${escapeHtml(item.message)}”</p>
    </div>
  `).join("");

  // Bản sao nối tiếp để cuộn dọc liền mạch vô tận
  const dupHtml = wishes.map((item) => `
    <div class="wish-item" aria-hidden="true">
      <div class="wish-meta">
        <span class="wish-author">✨ ${escapeHtml(item.name)}</span>
        <span class="wish-tag">${escapeHtml(item.attending || "Sẽ đến nhaa!")}</span>
      </div>
      <p class="wish-content">“${escapeHtml(item.message)}”</p>
    </div>
  `).join("");

  container.innerHTML = itemsHtml + dupHtml;
  container.classList.add("is-scrolling");

  // Điều chỉnh tốc độ cuộn mượt mà theo số lượng lời chúc
  const scrollDuration = Math.max(14, wishes.length * 6);
  container.style.animationDuration = `${scrollDuration}s`;
}

function initWishesBoard() {
  // 1. Hiển thị tức thì từ cache cục bộ (zero lag)
  const wishes = getStoredWishes();
  renderWishesList(wishes);

  // 2. Tự động đồng bộ từ Đám mây để ai mở link cũng thấy
  fetchCloudWishes();
}

async function addNewWish(newWish) {
  // 1. Hiển thị ngay lên màn hình cho người gửi
  let wishes = getStoredWishes();
  wishes = [newWish, ...wishes];
  try {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(wishes));
  } catch (e) {
    console.error("Lỗi lưu lời chúc:", e);
  }
  renderWishesList(wishes);

  // 2. Gửi đồng bộ lên Đám mây công khai để TẤT CẢ mọi người mở link đều thấy
  try {
    const res = await fetch(CLOUD_GUESTBOOK_API);
    if (res.ok) {
      const currentObj = await res.json();
      const currentWishes = (currentObj.data && Array.isArray(currentObj.data.wishes)) ? currentObj.data.wishes : [];
      const cleanWish = {
        name: newWish.name,
        attending: newWish.attending,
        message: newWish.message,
        time: "Vừa xong"
      };
      const updatedList = [cleanWish, ...currentWishes.filter(w => !isContentInappropriate(w.name + " " + w.message))];
      await fetch(CLOUD_GUESTBOOK_API, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          name: "Ngoctu Graduation Guestbook 2026",
          data: { wishes: updatedList }
        })
      });
    }
  } catch (cloudErr) {
    console.warn("Lỗi đồng bộ đám mây:", cloudErr);
  }
}

function escapeHtml(str) {
'@

$js = [System.Text.RegularExpressions.Regex]::Replace($js, $targetSection4Regex, $newSection4.Trim())

[System.IO.File]::WriteAllText("$PSScriptRoot\..\script.js", $js, [System.Text.Encoding]::UTF8)
Write-Host "Updated script.js successfully with Cloud Sync for v12!"
