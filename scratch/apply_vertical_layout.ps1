$htmlPath = "$PSScriptRoot\..\index.html"
$content = [System.IO.File]::ReadAllText($htmlPath, [System.Text.Encoding]::UTF8)

# 1. Remove connecting film ribbon wrapper
$ribbonStart = '<!-- THƯỚC PHIM NỐI 2 SECTION THEO MẪU DEMO (MỀM MẠI DỊU DÀNG) -->'
$ribbonEnd = '<!-- ================= SECTION 01: NẰM BÊN TRÁI'

$p1 = $content.IndexOf($ribbonStart)
$p2 = $content.IndexOf($ribbonEnd)

if ($p1 -ge 0 -and $p2 -gt $p1) {
    $content = $content.Substring(0, $p1) + $content.Substring($p2)
    Write-Host "Removed connecting film ribbon successfully."
} else {
    Write-Host "Ribbon markers not matched, checking alternate."
}

# 2. Update Section 01 class to include sec-card-dashed
$content = $content.Replace(
    '<section class="section-panel sec-left" id="section01" aria-label="Section 01 - Bìa tốt nghiệp Nguyễn Ngọc Tú">',
    '<section class="section-panel sec-left sec-card-dashed" id="section01" aria-label="Section 01 - Bìa tốt nghiệp Nguyễn Ngọc Tú">'
)

# 3. Add dashed divider between section01 and section02
$oldSecDivider = @"
        </section>

        <!-- ================= SECTION 02: NẰM BÊN PHẢI (THƯỚC PHIM 35MM TỰ ĐỘNG CHẠY) ================= -->
"@

$newSecDivider = @"
        </section>

        <!-- ĐƯỜNG LINE ĐỨT NGĂN CÁCH GIỮA SECTION 1 VÀ SECTION 2 -->
        <div class="section-dashed-divider" aria-hidden="true">
          <span class="divider-line"></span>
          <span class="divider-heart">♡</span>
          <span class="divider-line"></span>
        </div>

        <!-- ================= SECTION 02: NẰM BÊN PHẢI (THƯỚC PHIM 35MM TỰ ĐỘNG CHẠY) ================= -->
"@

$content = $content.Replace($oldSecDivider.Replace("`r`n", "`n"), $newSecDivider.Replace("`r`n", "`n"))
$content = $content.Replace($oldSecDivider, $newSecDivider)

# 4. Update Section 02 class to include sec-card-dashed
$content = $content.Replace(
    '<section class="section-panel sec-right" id="section02" aria-label="Section 02 - Dải phim 35mm Hành trình đại học">',
    '<section class="section-panel sec-right sec-card-dashed" id="section02" aria-label="Section 02 - Dải phim 35mm Hành trình đại học">'
)

# 5. Fix "GRADUATIO" => "GRADUATION"
$content = $content.Replace(
    '<span class="meta-tag">GRADUATIO</span>',
    '<span class="meta-tag">GRADUATION</span>'
)

# 6. In Spread 2, also add sec-card-dashed and divider between section 3 and section 4
$content = $content.Replace(
    '<section class="section-panel sec-left sec-letter-page" id="section03" aria-label="Section 03 - Thư mời thân thương">',
    '<section class="section-panel sec-left sec-letter-page sec-card-dashed" id="section03" aria-label="Section 03 - Thư mời thân thương">'
)

$oldSecDivider2 = @"
        </section>

        <!-- ================= SECTION 04 (TRANG PHẢI SPREAD 2): CHI TIẾT SỰ KIỆN, BẢN ĐỒ & GỬI XE ================= -->
"@

$newSecDivider2 = @"
        </section>

        <!-- ĐƯỜNG LINE ĐỨT NGĂN CÁCH GIỮA SECTION 3 VÀ SECTION 4 -->
        <div class="section-dashed-divider" aria-hidden="true">
          <span class="divider-line"></span>
          <span class="divider-heart">♡</span>
          <span class="divider-line"></span>
        </div>

        <!-- ================= SECTION 04 (TRANG PHẢI SPREAD 2): CHI TIẾT SỰ KIỆN, BẢN ĐỒ & GỬI XE ================= -->
"@

$content = $content.Replace($oldSecDivider2.Replace("`r`n", "`n"), $newSecDivider2.Replace("`r`n", "`n"))
$content = $content.Replace($oldSecDivider2, $newSecDivider2)

$content = $content.Replace(
    '<section class="section-panel sec-right sec-details-page" id="section04" aria-label="Section 04 - Chi tiết lễ tốt nghiệp và địa điểm">',
    '<section class="section-panel sec-right sec-details-page sec-card-dashed" id="section04" aria-label="Section 04 - Chi tiết lễ tốt nghiệp và địa điểm">'
)

[System.IO.File]::WriteAllText($htmlPath, $content, [System.Text.Encoding]::UTF8)
Write-Host "Updated index.html with vertical layout and dashed dividers successfully!"
