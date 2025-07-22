// Khai báo các biến toàn cục
let selectedVoucher = null; // Lưu trữ đối tượng voucher đang được áp dụng
let tempSelectedVoucher = null; // Voucher tạm thời được chọn trong modal

// Các biến sẽ được khởi tạo từ JSP
let vouchersDataFromJSP = [];
let pricePerAdult = 0;
let discountBaby = 0;
let discountChild = 0;
let maxQuantity = 0;

// Hàm khởi tạo dữ liệu từ JSP
function initializeBookingData(vouchersData, tourPrice, childDiscount, babyDiscount, maxQty) {
    vouchersDataFromJSP = vouchersData;
    pricePerAdult = tourPrice;
    discountChild = childDiscount;
    discountBaby = babyDiscount;
    maxQuantity = maxQty;
}

/**
 * Hàm mở modal chọn voucher
 */
function openDiscountModal() {
    const modal = document.getElementById('voucherModal');
    const container = document.getElementById('voucherListContainer');
    document.getElementById('voucherModal').style.display = 'flex';
    document.body.style.overflow = 'hidden'; // Ngăn cuộn nền
    
    // Xóa nội dung cũ
    container.innerHTML = '';

    // Tính tổng tiền hiện tại để kiểm tra điều kiện voucher
    const currentTotal = calculateCurrentTotal();

    if (vouchersDataFromJSP.length === 0) {
        container.innerHTML = '<p style="text-align: center; color: #666;">Không có mã giảm giá nào hiện có.</p>';
    } else {
        // Tạo danh sách voucher
        vouchersDataFromJSP.forEach(function (voucher) {
            const isEligible = currentTotal >= voucher.minimumOrderValue;
            const voucherDiv = document.createElement('div');
            voucherDiv.style.cssText = `
                margin-bottom: 10px; 
                padding: 15px; 
                border: 2px solid ${isEligible ? '#28a745' : '#dc3545'}; 
                border-radius: 8px; 
                cursor: ${isEligible ? 'pointer' : 'not-allowed'};
                background-color: ${isEligible ? '#f8f9fa' : '#f5f5f5'};
                opacity: ${isEligible ? '1' : '0.6'};
                transition: all 0.3s ease;
            `;

            if (isEligible) {
                voucherDiv.addEventListener('mouseenter', function () {
                    this.style.backgroundColor = '#e9ecef';
                    this.style.transform = 'translateY(-2px)';
                });
                voucherDiv.addEventListener('mouseleave', function () {
                    this.style.backgroundColor = '#f8f9fa';
                    this.style.transform = 'translateY(0)';
                });
            }

            voucherDiv.innerHTML = `
                <div style="display: flex; align-items: center; margin-bottom: 10px;">
                    <input type="radio" name="voucherOption" value="${voucher.voucherID}" 
                           id="voucher_${voucher.voucherID}" 
                           ${isEligible ? '' : 'disabled'}
                           ${selectedVoucher && selectedVoucher.voucherID == voucher.voucherID ? 'checked' : ''}
                           style="margin-right: 10px;">
                    <label for="voucher_${voucher.voucherID}" style="font-weight: bold; color: ${isEligible ? '#28a745' : '#dc3545'};">
                        ${voucher.title}
                    </label>
                </div>
                <div style="margin-left: 25px;">
                    <p style="margin: 5px 0; font-size: 0.9em;">
                        <i class="fas fa-percentage" style="color: #007bff; margin-right: 5px;"></i>
                        Giảm ${voucher.discount}%
                    </p>
                    <p style="margin: 5px 0; font-size: 0.9em;">
                        <i class="fas fa-coins" style="color: #ffc107; margin-right: 5px;"></i>
                        Đơn hàng tối thiểu: ${formatCurrency(voucher.minimumOrderValue)}
                    </p>
                    <p style="margin: 5px 0; font-size: 0.9em;">
                        <i class="fas fa-ticket-alt" style="color: #6c757d; margin-right: 5px;"></i>
                        Còn lại: ${voucher.numbers} voucher
                    </p>
                    ${!isEligible ? '<p style="margin: 5px 0; font-size: 0.85em; color: #dc3545; font-style: italic;"><i class="fas fa-exclamation-triangle" style="margin-right: 5px;"></i>Không đủ điều kiện áp dụng</p>' : ''}
                </div>
            `;

            if (isEligible) {
                voucherDiv.addEventListener('click', function () {
                    const radio = this.querySelector('input[type="radio"]');
                    radio.checked = true;
                    tempSelectedVoucher = voucher;
                });
            }

            container.appendChild(voucherDiv);
        });
    }

    modal.style.display = 'flex';
}

/**
 * Hàm đóng modal
 */
function closeDiscountModal() {
    document.getElementById('voucherModal').style.display = 'none';
    document.body.style.overflow = ''; // Cho phép cuộn lại
    tempSelectedVoucher = null;
}

/**
 * Hàm áp dụng voucher đã chọn
 */
function applySelectedVoucher() {
    const checkedRadio = document.querySelector('input[name="voucherOption"]:checked');
    if (checkedRadio) {
        const voucherId = parseInt(checkedRadio.value);
        selectedVoucher = vouchersDataFromJSP.find(v => v.voucherID === voucherId);

        if (selectedVoucher) {
            updateVoucherDisplay();
            updateTotal();
        }
    }
    closeDiscountModal();
}

/**
 * Hàm cập nhật hiển thị voucher đã chọn
 */
function updateVoucherDisplay() {
    const displayDiv = document.getElementById('selectedVoucherDisplay');
    const titleSpan = document.getElementById('selectedVoucherTitle');
    const discountSpan = document.getElementById('selectedVoucherDiscount');
    const amountSpan = document.getElementById('selectedVoucherAmount');

    if (selectedVoucher) {
        const currentTotal = calculateCurrentTotal();
        const voucherAmount = currentTotal * (selectedVoucher.discount / 100);

        titleSpan.textContent = selectedVoucher.title;
        discountSpan.textContent = selectedVoucher.discount;
        amountSpan.textContent = formatCurrency(voucherAmount);
        displayDiv.style.display = 'block';
    } else {
        displayDiv.style.display = 'none';
    }
}

/**
 * Hàm xóa voucher đã chọn
 */
function clearVoucher() {
    selectedVoucher = null;
    updateVoucherDisplay();
    updateTotal();
}

/**
 * Hàm tính tổng tiền hiện tại (trước khi áp dụng voucher)
 */
function calculateCurrentTotal() {
    const adultCount = parseInt(document.getElementById("adult-count").innerText);
    const childCount = parseInt(document.getElementById("child-count").innerText);
    const babyCount = parseInt(document.getElementById("baby-count").innerText);

    const totalAdult = adultCount * pricePerAdult;
    const totalChild = childCount * pricePerAdult * (1 - discountChild / 100);
    const totalBaby = babyCount * pricePerAdult * (1 - discountBaby / 100);

    return totalAdult + totalChild + totalBaby;
}

/**
 * Hàm thay đổi số lượng hành khách theo loại (adult, child, baby)
 * delta: +1 hoặc -1
 */
function changeCount(type, delta) {
    const id = type + '-count';
    const countElem = document.getElementById(id);
    let count = parseInt(countElem.innerText);

    // Tổng số vé hiện tại
    const adultCount = parseInt(document.getElementById("adult-count").innerText);
    const childCount = parseInt(document.getElementById("child-count").innerText);
    const babyCount = parseInt(document.getElementById("baby-count").innerText);
    const totalCurrent = adultCount + childCount + babyCount;

    // Nếu tăng và đã đủ số vé tối đa, thì không cho tăng
    if (delta > 0 && totalCurrent >= maxQuantity) {
        alert(`Tổng số vé không được vượt quá ${maxQuantity}!`);
        return;
    }

    // Giảm nhưng không được nhỏ hơn 0
    count = Math.max(0, count + delta);
    countElem.innerText = count;
    updateTotal();
}

/**
 * Hàm cập nhật tổng tiền, số lượng vé và ghi chú ẩn gửi server
 */
function updateTotal() {
    // Đọc số lượng từng loại hành khách
    const adultCount = parseInt(document.getElementById("adult-count").innerText);
    const childCount = parseInt(document.getElementById("child-count").innerText);
    const babyCount = parseInt(document.getElementById("baby-count").innerText);
    const totalCount = adultCount + childCount + babyCount;

    // Lấy giá trị ghi chú từ textarea
    const noteTextarea = document.querySelector('textarea[name="note"]');
    const noteValue = noteTextarea ? noteTextarea.value : '';

    // Tính tổng tiền từng nhóm sau khi áp dụng giảm giá theo loại hành khách
    const totalAdult = adultCount * pricePerAdult;
    const totalChild = childCount * pricePerAdult * (1 - discountChild / 100);
    const totalBaby = babyCount * pricePerAdult * (1 - discountBaby / 100);
    const subtotalBeforeVoucher = totalAdult + totalChild + totalBaby;

    // Áp dụng voucher giảm giá (nếu có)
    let voucherDiscountAmount = 0;
    let finalTotal = subtotalBeforeVoucher;

    if (selectedVoucher) {
        // Kiểm tra điều kiện tối thiểu
        if (subtotalBeforeVoucher >= selectedVoucher.minimumOrderValue) {
            voucherDiscountAmount = subtotalBeforeVoucher * (selectedVoucher.discount / 100);
            finalTotal = subtotalBeforeVoucher - voucherDiscountAmount;
        } else {
            // Nếu không đủ điều kiện, tự động hủy voucher
            selectedVoucher = null;
            updateVoucherDisplay();
        }
    }

    // Gán giá trị ẩn cho form gửi server
    const totalBillElement = document.getElementById("totalBill");
    const numberTicketElement = document.getElementById("numberTicket");
    const noteValueInputElement = document.getElementById("noteValueInput");
    const voucherIDElement = document.getElementById("voucherID");
    
    if (totalBillElement) totalBillElement.value = Math.floor(finalTotal);
    if (numberTicketElement) numberTicketElement.value = totalCount;
    if (noteValueInputElement) noteValueInputElement.value = noteValue;
    if (voucherIDElement) voucherIDElement.value = selectedVoucher ? selectedVoucher.voucherID : '';

    // Tính tổng tiền được giảm theo loại hành khách (để hiển thị)
    const totalChild_down = childCount * pricePerAdult * (1.0) * discountChild / 100.0;
    const totalBaby_down = babyCount * pricePerAdult * (1.0) * discountBaby / 100.0;
    const total_down = totalChild_down + totalBaby_down;

    // Cập nhật giao diện hiển thị
    const totalAmountElement = document.querySelector(".total-amount");
    if (totalAmountElement) {
        totalAmountElement.innerText = formatCurrency(finalTotal);
    }

    // Cập nhật các element nếu tồn tại
    const priceDownElement = document.getElementById("price_down");
    if (priceDownElement) {
        priceDownElement.innerText = formatCurrency(total_down);
    }

    const adultLineElement = document.getElementById("adult-line-value");
    if (adultLineElement) {
        adultLineElement.innerText = adultCount + " x " + formatCurrency(pricePerAdult);
    }

    const childLineElement = document.getElementById("child-line-value");
    if (childLineElement) {
        childLineElement.innerText = childCount + " x " + formatCurrency(pricePerAdult * (1 - discountChild / 100));
    }

    const babyLineElement = document.getElementById("baby-line-value");
    if (babyLineElement) {
        babyLineElement.innerText = babyCount + " x " + formatCurrency(pricePerAdult * (1 - discountBaby / 100));
    }

    // Hiển thị hoặc ẩn dòng trẻ em và em bé tùy số lượng
    const childLine = document.getElementById("child-line");
    if (childLine) {
        childLine.style.display = childCount > 0 ? "flex" : "none";
    }

    const babyLine = document.getElementById("baby-line");
    if (babyLine) {
        babyLine.style.display = babyCount > 0 ? "flex" : "none";
    }

    // Cập nhật hiển thị voucher nếu có
    if (selectedVoucher) {
        updateVoucherDisplay();
    }
}

/**
 * Hàm định dạng số thành chuỗi tiền tệ Việt Nam
 */
function formatCurrency(amount) {
    return amount.toLocaleString("vi-VN", {
        style: "currency",
        currency: "VND"
    });
}

// Hàm chuẩn bị gửi form
function prepareSubmit() {
    // Kiểm tra số lượng vé có hợp lệ không
    const adultCount = parseInt(document.getElementById("adult-count").innerText);
    const childCount = parseInt(document.getElementById("child-count").innerText);
    const babyCount = parseInt(document.getElementById("baby-count").innerText);
    const totalCount = adultCount + childCount + babyCount;

    if (totalCount <= 0) {
        alert("Vui lòng chọn ít nhất 1 vé!");
        return false;
    }

    // Cập nhật lại lần cuối cùng trước khi gửi
    updateTotal();

    // Nếu có voucher được chọn, cập nhật số lượng voucher
    if (selectedVoucher) {
        // Tìm voucher trong danh sách và giảm số lượng
        const voucherIndex = vouchersDataFromJSP.findIndex(v => v.voucherID === selectedVoucher.voucherID);
        if (voucherIndex !== -1) {
            vouchersDataFromJSP[voucherIndex].numbers -= 1;
        }
    }

    return true;
}

// Khởi tạo khi trang tải xong
function initializeBookingPage() {
    updateTotal(); // Cập nhật tổng tiền lúc đầu

    // Lắng nghe sự kiện nhập liệu ở ô ghi chú để cập nhật input ẩn ngay lập tức
    const noteTextarea = document.querySelector('textarea[name="note"]');
    if (noteTextarea) {
        noteTextarea.addEventListener('input', function () {
            const noteValueInputElement = document.getElementById("noteValueInput");
            if (noteValueInputElement) {
                noteValueInputElement.value = noteTextarea.value;
            }
        });
    }

    // Đóng modal khi click bên ngoài
    window.onclick = function (event) {
        const modal = document.getElementById('voucherModal');
        if (event.target === modal) {
            closeDiscountModal();
        }
    }
}

// Khi trang tải xong:
document.addEventListener("DOMContentLoaded", function () {
    initializeBookingPage();
});