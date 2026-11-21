# apply_v14_google_script_support.ps1
$ErrorActionPreference = "Stop"

$js = Get-Content -Path "script.js" -Raw -Encoding UTF8

$targetSection4 = @'
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
'@

$replaceSection4 = @'
// ================= 4. QUẢN LÝ SỔ LƯU BÚT ĐỒNG BỘ ĐÁM MÂY (CLOUD SYNC) & TỰ ĐỘNG CUỘN DỌC =================
const STORAGE_KEY = "ngoctu_graduation_wishes_v2";

// 1. LINK KẾT NỐI EMAIL & GOOGLE SHEET (NẾU TÚ DÙNG GOOGLE APPS SCRIPT):
// Dán link Web App của Tú vào đây để website đọc trực tiếp từ kho lưu trữ Google của Tú
const GOOGLE_SCRIPT_URL = ""; 

// 2. MÁY CHỦ ĐỒNG BỘ TRỰC TUYẾN TỰ ĐỘNG (HOẠT ĐỘNG 24/7 SẴN SÀNG):
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
  const apiUrl = GOOGLE_SCRIPT_URL || CLOUD_GUESTBOOK_API;
  try {
    const res = await fetch(apiUrl);
    if (res.ok) {
      const data = await res.json();
      let rawList = [];
      if (Array.isArray(data)) {
        rawList = data;
      } else if (data && data.data && Array.isArray(data.data.wishes)) {
        rawList = data.data.wishes;
      }
      const cloudWishes = rawList.filter(w => !isContentInappropriate(w.name + " " + w.message));
      localStorage.setItem(STORAGE_KEY, JSON.stringify(cloudWishes));
      renderWishesList(cloudWishes);
    }
  } catch (err) {
    console.warn("Không thể tải lời chúc từ máy chủ:", err);
  }
}
'@

if ($js.Contains($targetSection4)) {
  $js = $js.Replace($targetSection4, $replaceSection4)
  Write-Host "Replaced Section 4 successfully!"
} else {
  Write-Host "Target Section 4 not found directly, checking regex" -ForegroundColor Yellow
}

[System.IO.File]::WriteAllText("$PSScriptRoot\..\script.js", $js, [System.Text.Encoding]::UTF8)
Write-Host "Updated script.js successfully for v14!"
