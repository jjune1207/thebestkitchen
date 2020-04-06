"use strict";

var product = {}
// validateProductOption request options info
var options = []
var optionMainImages = []
var optionSubImages = []
var reviewImgSrcAll = new Array();
var refetchReviewImgSrcAll = new Array();
var productInfo = {
    "inquiry": [],
    "review": []
}
var inquiryPageInfo = {
    "pageNumber": 1,
    "pageSize": 10,
    "hasTotalCount": true,
    "isMyInquiries": false,
}
var reviewPageInfo = {
    "pageNumber": 1,
    "pageSize": 10,
    "hasTotalCount": true,
    "isMyInquiries": false,
    "order.by": 'RECOMMEND'
}
var optionInfo = new Array();

var productNo = shop.getUrlParam('pno');
var buyAction = "";
var currentEditId = "";
var optionNo = '';
if (productNo) {

} else {
    console.log('product no error')
    forwordToTop();
}

var downloadCoupon = function (couponNo) {
    if (!shop.isLogin()) {
        forwordToLoginPage(window.location.href);
    } else {
        shop.coupon.downLoadCoupon(couponNo, function (coupon) {
            alert('할인쿠폰이 발급되었습니다.');
        });
    }
}

$('#btnPopOk').click(function () {
    $('.popup-detail').css('display', 'none');
    window.location.href = './cart.html';
});

$('#btnPopCancel').click(function () {
    $('.popup-detail').css('display', 'none');
});

$('#btnPopClose').click(function () {
    $('.popup-detail').css('display', 'none');
});

$('.tab-goods li a').click(function () {
    $('.tab-goods li').removeClass('on');
    var idx = $(this).attr('data-idx');
    $('.tab-goods li').eq(idx - 1).addClass('on');
    $('.con-goods').hide();
    $('.con-service').hide();
    $('.con-consultation').hide();
    $('.purchase-guide').hide();
    if (idx === "1") {
        $('.con-goods').show();
    } else if (idx === "2") {
        $('.purchase-guide').show();
    } else if (idx === "3") {
        $('.con-service').show();
    } else if (idx === "4") {
        $('.con-consultation').show();
    }
});

$('#contentInquiry').focus(function (e) {
    if (!shop.isLogin()) {
        forwordToLoginPage(window.location.href);
    }
});

$('#formInquiry').submit(function (e) {
    e.preventDefault();
    if (!shop.isLogin()) {
        forwordToLoginPage(window.location.href);
        return
    }
    var content = $.trim($('#contentInquiry').val());
    if (content.length == 0) {
        alert('내용을 입력해주세요.');
        return;
    }

    var isSecreted = $('#secretedCheckBox').is(':checked');
    var param = {};
    param.productNo = productNo;
    param.type = 'PRODUCT';
    param.title = '';
    param.content = content;
    param.secreted = isSecreted;
    param.parentInquiryNO = 0;
    shop.product.addInquiry(productNo, param, function () {
        shop.product.reFetchInquiry(productNo, renderInquiry);
        $('#contentInquiry').val('');
        $('#secretedCheckBox').attr('checked', false);
    });
});

$('#formReview').submit(function (e) {
    e.preventDefault();

    var content = $.trim($('#contentReview').val());
    if (content.length == 0) {
        alert('내용을 입력해주세요.');
        return;
    }

    var rate = 1;
    var selectRete = $('#formReview .select-result').data('star');
    rate = parseInt(selectRete.substring(5, 6));

    var urls = [];
    var images = $('#formReview li img');
    for (var i = 0; i < images.length; i++) {
        urls.push(images[i].src);
    }

    var optionNo = $('#formReview input[name=optionNo]').val();
    var orderOptionNo = $('#formReview input[name=orderOptionNo]').val();

    var param = {};
    param.productNo = productNo;
    param.optionNo = parseInt(optionNo);
    param.orderOptionNo = parseInt(orderOptionNo);
    param.content = content;
    param.rate = rate;
    param.urls = urls;

    shop.product.addReview(param, function () {
        shop.product.reFetchReview(productNo, renderReview);
        $('#formReview').hide();
        var imgs = $('#formReview li img');
        for (var j = 0; j < imgs.length; j++) {
            imgs[j].parentElement.remove();
        }

        $('#formReview textarea').val('');
        $('#formReview .select-result').attr('class', 'select-result').addClass('star-5');
    });

});

var addImageTarget = '';

$('#fileInput').change(function (e) {
    shop.product.uploadImage(function (result, imageUrl) {
        if (result === 'success') {
            var html = '<li>';
            html += '<img src="' + imageUrl + '" class="p-img" alt="">';
            html += '<button type="button" onclick="removeReviewImg(this)" class="btn-close-1">close</button>';
            html += '</li>';
            $(html).insertBefore('#' + addImageTarget);
        }
    });
});

var addImage = function (target, idx) {
    const IMG_COUNT_LIMIT = 10;
    if ($('#reviewImageList li img').length >= IMG_COUNT_LIMIT || $('#formReview' + idx + ' li img').length >= IMG_COUNT_LIMIT) {
        alert('포토리뷰는 최대 ' + IMG_COUNT_LIMIT + '개까지 등록 가능합니다.')
        return false
    }
    $('#fileInput').click();
    addImageTarget = target;
}

var removeReviewImg = function (ctrl) {
    var li = $(ctrl).parent();
    li.remove();
};

$('#purchaseInfo').on('click', '#btnBuy', function () {
    if (buyAction !== '') {
        return;
    }
    buyAction = 'BUY';
    BeforeValidate();
});
$('.btn-payco-pay').click(function () {
    if (buyAction !== '') {
        return;
    }
    buyAction = 'BUY';
    BeforeValidate();
});

$('#purchaseInfo').on('click', '#btnAddToCart', function (e) {
    if (buyAction !== '') {
        return;
    }
    buyAction = 'ADD';
    BeforeValidate();

});
/*
$('#orderCnt').on('keyup', function(){
    if ($(this).val() == 0) {
        ValidateFailed('최소 주문수량은 1개입니다. 주문 수량을 확인해주세요.');
        $(this).val('1');
    }
    return false;
})
*/
var ValidateFailed = function (message) {
    alert(message);
    buyAction = '';
}

var ValidateEnd = function () {
    buyAction = '';
}

var buyCountInputCheck = function (obj,optionNo) {
    obj.value = obj.value.replace(/\D/g, '');
    var cnt = obj.value;
    if (isNaN(cnt) || cnt <= 0) {
        alert('최소수량은 1이상입니다.');
        obj.value = 1;
    }
    if(optionNo) {
        setTotalOptionPrice(optionNo,cnt);
        setTotalPrice();
    }
}

var BeforeValidate = function () {
    // var optionNo = $('.select-normal').val();
    if (product.stock.stockCnt == 0) {
        ValidateFailed('품절된 상품입니다.');
        return false;
    }

    if (options.length > 1 && $('div[id^="opBox-"]').length < 1) {
        ValidateFailed('옵션을 선택해주세요.')
        return false;
    }
/*
    var cnt = Number($('#orderCnt').val());
    if (isNaN(cnt) || cnt <= 0) {
        ValidateFailed('최소 주문수량은 1개입니다. 주문 수량을 확인해주세요.');
        return;
    }
*/
    shop.product.getDetail(productNo, function (product) {
        validateProduct(product);
    });
    return true;
}

var validateProduct = function (product) {
    if (!product.status.display) {
        ValidateFailed('이 상품은 현재 구매가 불가능합니다.')
        return false;
    }
    if (product.status.saleStatusType !== 'ONSALE') {
        ValidateFailed('이 상품은 현재 구매가 불가능합니다.')
        return false;
    }


    shop.product.getOption(productNo, function (product) {
        validateProductOption();
    });
    return true;
}

var validateProductOption = function () {
    var selectedOption = undefined;
    var buyCnt = 0;
    if(options.length > 1){
        var validateFail = false;
        buyCnt = 0;
        $('div[id^="opBox-"]').each(function () {
            var tmpOptNo = $(this).attr('id').replace('opBox-','');
            buyCnt += Number($('#orderCnt-' + tmpOptNo).val());
            if(!validateMultiOption(tmpOptNo)){
                validateFail = true;
                return false;
            }
        });

        if(validateFail){
            return false;
        }

    }else{

        buyCnt = Number($('#orderCnt').val());
        for (var i = 0; i < options.length; i++) {
            if (options[i].optionNo == Number(optionNo)) {
                selectedOption = options[i];
            }
        }
        if (selectedOption === undefined) {
            ValidateFailed('상품 옵션을 선택 해 주세요.')
            return false;
        }

        if (selectedOption.stockCnt === 0) {
            ValidateFailed('선택하신 옵션이 품절되었습니다.')
            return false
        }
        if (buyCnt > selectedOption.stockCnt) {
            ValidateFailed('상품의 재고가 부족합니다. 수량을 다시 확인 해 주세요.')
            return false
        }
    }


    validateBuyCnt(buyCnt);
    return true;
}

var validateBuyCnt = function (buyCnt) {

    /** min buy check */
    if (product.limitations.minBuyCnt !== 0 && buyCnt < product.limitations.minBuyCnt) {
        ValidateFailed('이 상품은 최소 ' + product.limitations.minBuyCnt + '개이상 구매 가능한 상품입니다. 수량을 다시 확인 해 주세요.');
        return false;
    }

    /** Time max Buy Cnt check */
    if ((product.limitations.maxBuyTimeCnt !== 0 && buyCnt > product.limitations.maxBuyTimeCnt) ||
        (product.limitations.maxBuyPeriodCnt !== 0 && buyCnt > product.limitations.maxBuyPeriodCnt) ||
        (product.limitations.maxBuyPersonCnt !== 0 && buyCnt > product.limitations.maxBuyPersonCnt)) {
        var maxCnt = product.limitations.maxBuyTimeCnt | product.limitations.maxBuyPeriodCnt | this.product.limitations.maxBuyPersonCnt;
        if (buyCnt > maxCnt) {
            ValidateFailed('이 상품은 최대 ' + maxCnt + '개 구매 가능한 상품입니다. 수량을 다시 확인 해 주세요.');
            return false;
        }

    } else if (product.limitations.maxBuyTimeCnt === 0 && product.limitations.maxBuyPeriodCnt === 0 && product.limitations.maxBuyPersonCnt === 0) {
        var maxCnt = 9999;
        if (buyCnt > maxCnt) {
            ValidateFailed('이 상품은 최대 ' + maxCnt + '개 구매 가능한 상품입니다. 수량을 다시 확인 해 주세요.');
            return false;
        }
    }

    var memberOnly = false
    if (product.limitations.memberOnly ||
        product.limitations.maxBuyPersonCnt !== 0 ||
        product.limitations.maxBuyDays !== 0 ||
        product.limitations.maxBuyPeriodCnt !== 0) {
        memberOnly = true
    }
    if (shop.isLogin() && memberOnly) {
        shop.profile.fetchMemberInfo(function (res) {
            validateMemberInfo(res);
        })
    } else {
        if (buyAction === 'ADD') {
            addToCart();
        } else if (buyAction === 'BUY') {
            toOrderSheet();
        }
    }
    return true;
}

var validateMemberInfo = function (member) {
    if (!member.ncpCertificated) {
        ValidateFailed('본인인증을 한 PAYCO ID를 통해서만 구매가 가능합니다. 본인인증을 진행해주세요.')
        forwordToLoginPage(window.location.href);
        return false
    }
    if (!this.profile.adultCertificated) {
        ValidateFailed('이 상품은 성인만 구매 가능합니다.')
        return false
    }

    if (buyAction === 'ADD') {
        addToCart();
    } else if (buyAction === 'BUY') {
        toOrderSheet();
    }
}

var addToCart = function () {
    ValidateEnd();
    var cnt,param;

    if(options.length > 1){
        param = [];
        $('div[id^="opBox-"]').each(function () {
            var tmpOptNo = $(this).attr('id').replace('opBox-','');
            cnt = Number($('#orderCnt-' + tmpOptNo).val());
            var objOpt = {};
            objOpt.productNo = Number(productNo);
            objOpt.optionNo = Number(tmpOptNo);
            objOpt.additionalProductNo = 0;
            objOpt.orderCnt = cnt;
            objOpt.optionInputs = [];
            param.push(objOpt);
        });
    }else{
        cnt = Number($('#orderCnt').val());
        param = [{}];
        param[0].productNo = Number(productNo);
        param[0].optionNo = Number(optionNo);
        param[0].additionalProductNo = 0;
        param[0].orderCnt = cnt;
        param[0].optionInputs = [];
    }

    if (shop.isLogin()) {
        shop.product.addToRemoteCart(param, function () {
            $('.popup-detail').css('display', 'block');
            //alert('addToRemoteCart success');
        });
    } else {
        shop.product.addToLocalCart(param, function () {
            //alert('addToLocalCart success');
            $('.popup-detail').css('display', 'block');
        });
    }
}

var toOrderSheet = function () {
    ValidateEnd();
    var orderCartsNo,orderProducts,cnt;
    if(options.length > 1) {
        orderCartsNo = [];
        orderProducts = [];
        $('div[id^="opBox-"]').each(function (index) {
            var tmpOptNo = $(this).attr('id').replace('opBox-', '');
            cnt = Number($('#orderCnt-' + tmpOptNo).val());
            var objOpt = {};
            objOpt.productNo = Number(productNo);
            objOpt.optionNo = Number(tmpOptNo);
            objOpt.additionalProductNo = 0;
            objOpt.orderCnt = cnt;
            objOpt.optionInputs = [];
            orderProducts.push(objOpt);
            orderCartsNo.push(index);
        });
    }else{
        cnt = Number($('#orderCnt').val());
        orderCartsNo = [0];
        orderProducts = [{}];

        orderProducts[0].productNo = Number(productNo);
        orderProducts[0].optionNo = Number(optionNo);
        orderProducts[0].additionalProductNo = 0;
        orderProducts[0].orderCnt = cnt;
        orderProducts[0].optionInputs = [];
    }

    var preOrders = {
        "cartNos": orderCartsNo,
        "products": orderProducts,
        "productCoupons": null,
        "trackingKey": null
    }

    var preOrdersJson = JSON.stringify(preOrders);
    setOrderInfoInStorage(preOrdersJson, window.location.href);

    var nexturl = './beforeorder.html';

    if (!shop.isLogin()) {
        if (product.limitations.memberOnly) {
            alert('이 상품은 회원만 구매 가능한 상품입니다. 로그인 해 주세요.');
            var loginUrl = './loginA.html?memberonly=true&nextUrl=' + encodeURIComponent(nexturl)
            window.location.href = loginUrl;
        } else {
            var loginUrl = './loginA.html?nextUrl=' + encodeURIComponent(nexturl)
            window.location.href = loginUrl;
        }
    } else {
        window.location.href = nexturl;
    }
}

$('#btnMoreReview').click(function (e) {
    shop.product.fetchReview(productNo, renderReview);
});

$('#btnMoreInquiry').click(function (e) {
    shop.product.fetchInquiry(productNo, renderInquiry);
});

var showDetail = function (obj) {
    $(obj).next().toggle();
    // $(obj).next().find('img').each(function(idx){
    //     reviewImgSrcAll[idx] = $(this).attr('src');
    // });
}

var modifyReview = function (ctrl, index) {
    var e = getEvent();
    e.stopPropagation();
    if (currentEditId !== '') {
        $('#modform' + currentEditId).remove();
        var target = $('#' + currentEditId);
        target.show();
    }
    currentEditId = 'review' + index;

    var info = shop.product.getReview(index);
    var target = $('#review' + index);
    target.after('<tr id="modformreview' + index + '" style="display: block;"></tr>');
    $('#review-modify-template').renderTemplate({ "review": info, "index": index }, '#modformreview' + index);
    updateStartSnsDrop("#starSelect" + index);
    target.hide();
    $('#reviewAnswer' + index).hide();
}

var submitModifyReview = function (index) {
    var e = getEvent();
    e.stopPropagation();
    e.preventDefault();

    var content = $.trim($('#modformreview' + index + ' textarea').val());
    if (content.length == 0) {
        alert('내용을 입력해주세요.');
        return;
    }

    var rate = 1;
    var selectRete = $('#modformreview' + index + ' .select-result').data('star');
    rate = parseInt(selectRete.substring(5, 6));

    var urls = [];
    var images = $('#modformreview' + index + ' li img');
    for (var i = 0; i < images.length; i++) {
        urls.push(images[i].src);
    }

    var no = $('#modformreview' + index + ' input[name=reviewNo]').val();

    var param = {};
    param.productNo = productNo;
    param.content = content;
    param.rate = rate;
    param.urls = urls;

    shop.product.putReview(productNo, no, param, function () {
        currentEditId = '';
        shop.product.reFetchReview(productNo, renderReview);
        $('#modformreview' + index).remove();
        var target = $('#review' + index);
        target.show();
        //$('#reviewAnswer' + index).show();
    });
}

var cancelModifyReview = function (index) {
    var e = getEvent();
    e.stopPropagation();

    $('#modformreview' + index).remove();
    var target = $('#review' + index);
    target.show();
    //$('#inquiryAnswer' + index).show();
    currentEditId = '';
}

var deleteReview = function (ctrl, no) {
    var e = getEvent();
    e.stopPropagation();
    if (no && no.length > 0) {
        if (confirm('상품평을 삭제하시면 복구하거나 다시 작성할 수 없습니다 삭제하시겠습니까?')) {
            $(ctrl).attr('disabled', "true");
            shop.product.deleteReview(productNo, no, function () {
                shop.product.reFetchReview(productNo, renderReview);
            });
        }
    }
}

var modifyInquiry = function (ctrl, index) {
    var e = getEvent();
    e.stopPropagation();
    if (currentEditId !== '') {
        $('#modform' + currentEditId).remove();
        var target = $('#' + currentEditId);
        target.show();
    }
    currentEditId = 'inquiry' + index;

    var inquiry = shop.product.getInquiry(index);
    var target = $('#inquiry' + index);
    target.after('<tr id="modforminquiry' + index + '" style="display:block"></tr>');
    $('#inquiriy-modify-template').renderTemplate({ "inquiriy": inquiry, "index": index }, '#modforminquiry' + index);

    target.hide();
    $('#inquiryAnswer' + index).hide();
}

var submitModifyInquiry = function (index) {
    var e = getEvent();
    e.stopPropagation();
    e.preventDefault();

    var content = $.trim($('#modforminquiry' + index + ' textarea').val());
    if (content.length == 0) {
        alert('내용을 입력해주세요.');
        return;
    }
    var secreted = $('#modforminquiry' + index + ' input[type=checkbox]').is(':checked');
    var no = $('#modforminquiry' + index + ' input[type=hidden]').val();

    var isSecreted = secreted;

    var param = {};
    //param.productNo = productNo;
    param.type = 'PRODUCT';
    param.title = '';
    param.content = content;
    param.secreted = isSecreted;
    param.parentInquiryNO = 0;
    shop.product.putInquiry(no, param, function () {
        currentEditId = '';
        shop.product.reFetchInquiry(productNo, renderInquiry);
        $('#modforminquiry' + index).remove();
        var target = $('#inquiry' + index);
        target.show();
        if ($('#inquiryAnswer' + index + ' .message').html().trim() != '') {
            $('#inquiryAnswer' + index).show();
        }
    });
}

var cancelModifyInquiry = function (index) {
    var e = getEvent();
    e.stopPropagation();

    $('#modforminquiry' + index).remove();
    var target = $('#inquiry' + index);
    target.show();
    if ($('#inquiryAnswer' + index + ' .message').html().trim() != '') {
        $('#inquiryAnswer' + index).show();
    }
    currentEditId = '';
}

var deleteInquiry = function (ctrl, no) {
    var e = getEvent();
    e.stopPropagation();
    if (no && no.length > 0) {
        if (confirm('문의글을 삭제하시겠습니까?')) {
            $(ctrl).attr('disabled', "true");
            shop.product.deleteInquiry(no, function () {
                shop.product.reFetchInquiry(productNo, renderInquiry);
            });
        }
    }
}

var renderReview = function (items, total) {
    if (items.length >= total) {
        $('#btnMoreReview').hide();
    }
    $('#reviews-template').renderTemplate({ "items": items }, "#proReview");
}

var renderInquiry = function (items, total) {
    $('#btnMoreInquiry').show();
    if (items.length >= total) {
        $('#btnMoreInquiry').hide();
    }

    for (var i = 0; i < items.length; i++) {
        if (items[i].answers) {
            for (var j = 0; j < items[i].answers.length; j++) {
                if (items[i].answers[j].adminType === 'READYSHOP') {
                    items[i].answers[j].adminName = '운영자';
                } else {
                    items[i].answers[j].adminName = items[i].answers[j].nickName;
                }
            }
        }
    }
    $('#inquiries-template').renderTemplate({ "items": items }, "#proInquiry");
}

var renderDetail = function (product) {
    if(!product.status.display){
        alert('이 상품은 현재 판매하고 있지 않습니다.');
        if(opener){
            self.close();
        }else{
            history.back();
        }
    }
    var baseInfo = product.baseInfo;
    var items = product.baseInfo.imageUrls;
    var price = product.price;
    var limit = product.limitations;
    var categories = product.categories;
    $('#promotionText').html(baseInfo.promotionText);
    $('#productName').html(baseInfo.productName);
    $('.more_name').html(baseInfo.productName);
    if (baseInfo.purchaseGuide) {
        $('.purchase-guide').html(baseInfo.purchaseGuide);
        $('#purchase-guide').show();
    }
    var dutyInfo = JSON.parse(baseInfo.dutyInfo)
    if (dutyInfo.contents && dutyInfo.contents.length > 0) {
        var dutyItems = [];
        for (var key in dutyInfo.contents) {
            var content = dutyInfo.contents[key]
            for (var key in content) {
                dutyItems.push({
                    'key': key,
                    'value': content[key]
                });
            }
        }
        $('#duty-template').renderTemplate({ "items": dutyItems }, "#dutyInfoContents");
    }

    var discountAmt = price.additionDiscountAmt + price.immediateDiscountAmt;
    if (discountAmt && discountAmt > 0) {
        var totalPrice = price.salePrice - discountAmt;
        $('#totalPrice').html(formatCurrency(totalPrice) + '<i>원</i>');
        $('#salePrice').html(formatCurrency(price.salePrice) + '<i>원</i>');
    } else {
        $('#totalPrice').html(formatCurrency(price.salePrice) + '<i>원</i>');
    }
    var deliveryHtml = "";
    var deliveryAmt = product.deliveryFee.deliveryAmt;
    if (product.deliveryFee.deliveryConditionType === 'FREE') {
        deliveryHtml = "무료배송"
    } else if (product.deliveryFee.deliveryConditionType === 'FIXED_FEE') {
        deliveryHtml = formatCurrency(deliveryAmt) + '원'
    } else if (product.deliveryFee.deliveryConditionType === 'CONDITIONAL') {
        deliveryHtml = formatCurrency(deliveryAmt) + '원' + '(' + formatCurrency(product.deliveryFee.aboveDeliveryAmt) + '원 이상 구매 시 무료배송)'
    } else if (product.deliveryFee.deliveryConditionType !== 'FREE' && product.deliveryFee.deliveryPrePayment === false) {
        deliveryHtml = "착불"
    }
    $('#deliveryAmt').html(deliveryHtml);
    if (!limit.canAddToCart) {
        $('#btnAddToCart').hide();
        // $('#btnAddToCart').attr('disabled', "true");
    }

    var stockText, stockClass = '';
    if(product.status.saleStatusType == 'STOP'){
        stockText = '판매중지';
        stockClass = 'type3';
    }else{
        if (product.stock.stockCnt < 5 && product.stock.stockCnt > 0) {
            stockText = '품절임박';
            stockClass = 'type2';
        } else if (product.stock.stockCnt <= 0) {
            stockText = '품절';
            stockClass = 'type1';
        }
    }

    items.forEach(function (image) {
        $('.slider-1').slick('slickAdd', '<div style="outline:none;"><p><span><img src="' + image + '" alt=""></span></p><div class="exhibition_soldout ' + stockClass + '">' + stockText + '</div></div>');
        $('.slider-2').slick('slickAdd', '<div style="outline:none;" onclick="onClickSlide(this)"><p><span><img src="' + image + '" alt=""></span></p></div>');
    });
    if (items.length > 3) { //---> subDetail.1.0.js > slideCount
        $('.slider-2').slick('slickSetOption', 'swipe', true, true);
    }
    // $('#detail-images-template').renderTemplate({ "items": items, "content": baseInfo.content }, "#proDetailImages");
    $('#detail-images-template').renderTemplate({ "content": baseInfo.content }, "#proDetailImages");

    $('.img-switch img').load(function(){
        sliderResize(0,'productDetailImg');
    })

    if (categories.length > 0) {
        if (categories[0].categories && categories[0].categories.length > 0) {
            $('#cate-template').renderTemplate({ "items": categories[0].categories }, ".level");
        } else {
            var html = "<li><a href='./index.html'>Home</a></li>";
            $('.level').html(html);
        }
    } else {
        var html = "<li><a href='./index.html'>Home</a></li>";
        $('.level').html(html);
    }

    var btnList = '';
    if(product.status.saleStatusType == 'STOP'){
        $('.onsale').hide();
        if(product.price.contentsIfPausing && product.price.contentsIfPausing !== null && product.price.contentsIfPausing != ''){
            $('#contentsIfPausing').text(product.price.contentsIfPausing);
            $('.onsale.contentsIfPausing').show();
        }else{
            $('.onsale.price').show();
        }
        btnList = '<li class="non-onsale"><button id="" type="button" class="btn gray-2 style-10" disabled>구매불가</button></li>';
    }else{
        if (baseInfo.salePeriodType == 'PERIOD') {
            $('#saleStatus').show();
            $('#saleStatus dd .date1').text(baseInfo.saleStartYmdt.substr(5, 5).replace('-', '.'));
            $('#saleStatus dd .date2').text(baseInfo.saleEndYmdt.substr(5, 5).replace('-', '.'));
            if (product.status.saleStatusType == 'ONSALE') {
                $('.onsale').show();
                btnList = '<li class="onsale"><button id="btnBuy" type="button" class="btn black style-2-1">구매하기</button></li><li class="onsale"><button id="btnAddToCart" type="button" class="btn white-2 style-2-1">장바구니</button></li>';
            } else {
                if (product.status.saleStatusType == 'READY') {
                    $('#saleStatus').addClass('draws_near');
                    $('#saleStatus dt').text('판매임박');
                } else if (product.status.saleStatusType == 'FINISHED') {
                    $('#saleStatus').addClass('sold_out')
                    $('#saleStatus dt').text('판매종료');
                }
                $('.onsale').hide();
                btnList = '<li class="non-onsale"><button id="" type="button" class="btn gray-2 style-10" disabled>구매불가</button></li>';
            }
        } else {
            btnList = '<li class="onsale"><button id="btnBuy" type="button" class="btn black style-2-1">구매하기</button></li><li class="onsale"><button id="btnAddToCart" type="button" class="btn white-2 style-2-1">장바구니</button></li>';
        }
    }

    $('#purchaseInfo .btn-list').append(btnList);
}

var renderOption = function (name, items) {
    // $('#optionName').html(name);
    var html = "";
    var soldOutCnt = 0;
    var defaultHtml = '<li><a style="background: #ccc;">[필수] 선택해 주세요.</a></li>'

    if (items.length > 1) {
        html += defaultHtml;
    }

    for (var i = 0; i < items.length; i++) {
        var item = items[i];
        var optionLable = item.value;
        if (item.addPrice > 0) {
            optionLable += " (+" + formatCurrency(item.addPrice) + "원)"
        } else if (item.addPrice < 0) {
            optionLable += " (" + formatCurrency(item.addPrice) + "원)"
        }
        var aOpt = '<li><a href="javascript:;"'
        if (item.stockCnt < 1) {
            aOpt += ' style="background: #ccc;"';
            soldOutCnt++;
        } else {
            aOpt += ' onclick="changeOption(' + item.optionNo + ',\'' + optionLable + '\',' + i +')"'
        }
        aOpt += ">";
        aOpt += optionLable;
        aOpt += "</a></li>";
        html += aOpt;
    }
    if (soldOutCnt == items.length) {
        $('.lst_sub_option').html(defaultHtml)
        $('.txt_select_1').addClass("disabled");
    } else {
        $('.lst_sub_option').html(html);
    }
    $('.txt_select_1').click(function () {
        if ($('.txt_select_1').hasClass("on")) {
            $('.txt_select_1').removeClass('on');
        } else {
            $('.txt_select_1').addClass('on');
        }
    });
    if (items.length > 1) {
        changeOption('', '[필수] 선택해 주세요.')
    } else {
        changeOption(items[0].optionNo, items[0].value, 0)
    }
}

var changeOption = function (number, label, index) {
    optionNo = number
    $('.txt_select_1').removeClass('on');
    $('.txt_select_1').html(label + '<span class="arrow">' + label + '</span > ');

    if(options.length > 1 && number){
        if($('#opBox-'+ optionNo).length > 0){
            alert('이미 선택되어 있는 옵션입니다.');
        }else{
            var target = $('.option-wrap');
            target.append('<div class="op-box" id="opBox-'+ optionNo+'"></div>');
            var multiOption = {};
            multiOption.optionNo = optionNo;
            multiOption.label = label;
            multiOption.buyPrice = options[index].buyPrice;
            multiOption.showBuyPrice = formatCurrency(options[index].buyPrice);
            if(shop.getPlatform() == 'MOBILE_WEB') {
                multiOption.inputType = 'number';
            }else{
                multiOption.inputType = 'text';
            }
            $('#multi-option-template').renderTemplate({ "item": multiOption }, '#opBox-'+ optionNo);
            setTotalPrice();
        }
    }
    if(options.length < 2) {
        $('.total-wrap').hide();
        $('dl.number').show();
        if(shop.getPlatform() == 'MOBILE_WEB') {
            document.getElementById("orderCnt"). setAttribute ( 'type', 'number');
        }


    }
}

var renderOptionMainImage = function (images) {
    $.each(images, function(idx, value){
        $.each(options, function(idx1, value1){
            if (value1.optionNo == value.optionNo) {
                value.value = value1.value.replace(/[|]/g, '  ');
            }
        })
    })
    $('#option-images-popup-template').renderTemplate({ "items": images }, "#optionMainImages");
}

var renderOptionSubImage = function (optionNo) {
    var optionSubImageCnt;
    for(var i=0; i< optionSubImages.length;i++){
        if (optionSubImages[i].optionNo == optionNo) {
            optionSubImageCnt = optionSubImages[i].images.length;
            for (var j = 0; j < optionSubImages[i].images.length; j++) {
                $('.option-slider').slick('slickAdd','<div><img src="' + optionSubImages[i].images[j] + '"></div>');
            }
        }
    }

     $('.option-slider img').load(function(){
         $('.option-slider img').hide();
         $('.option-slider img').eq(0).show();
       sliderResize(0, 'productOptionImg');
     })

    if (optionSubImageCnt == 1) {
        $('.popup-more .area_contents button').hide();
    } else {
        $('.popup-more .area_contents button').show();
    }
    // imgOptionPage(optionSubImageCnt)
}

/*var imgOptionPage = function (cnt) {
    $('.img-cnt .total').text('/' + cnt);
    $('.btn_prev').on('click', function(){
        var nowPage = (parseInt($('.img-cnt .first').text()) - 1);
        if (nowPage == 0) nowPage = cnt;
        $('.img-cnt .first').text(nowPage);
    })
    $('.btn_next').on('click', function(){
        var nowPage = parseInt($('.img-cnt .first').text()) + 1;
        if (nowPage > cnt) nowPage = 1;
        $('.img-cnt .first').text(nowPage);
    })
}*/

var cntSet = function (type,optionNo) {

    var cntElement = null;
    if(optionNo){
        cntElement = $('#orderCnt-' + optionNo);
    }else{
        cntElement = $('#orderCnt');
    }

    var orderCnt = cntElement.val();
    if (type == 'plus') {
        orderCnt = eval(orderCnt) + 1;
    } else if (type == 'minus') {
        orderCnt = eval(orderCnt) - 1;
    }
    orderCnt = Number(orderCnt.toString().replace(/\D/g, '')) || 1;

    if (eval(orderCnt) < 1) {
        orderCnt = 1;
    }
    if (eval(orderCnt) > 9999) {
        orderCnt = 9999;
    }
    cntElement.val(eval(orderCnt));

    if(optionNo) {
        setTotalOptionPrice(optionNo,orderCnt);
        setTotalPrice();
    }
}







var getEvent = function () {
    return window.event || arguments.callee.caller.arguments[0];
}

var updateLength = function (key) {
    var len = $('.textarea_' + key).val().length;
    $('.length_' + key).text(len + '자 / 1000자');
}

let scrollTop = 0;
var showOptionPop = function (optionNo) {
    $('.popup-mask').show();

    var idx = 0;
    while(options) {
        if (options[idx].optionNo == optionNo) {
            $('.more_name').text(options[idx].value.replace(/[|]/g, '  '));
            break;
        }
        idx++;
    }
    scrollTop = 0;
    scrollTop = $("html,body").scrollTop();
    $('html,body').addClass('ovfHiden');
    if (!isPC()) {
        $('.wrap.mobile').hide();
        $('#footer').hide();
        $('body').css('position', 'fixed');
    }

    $('.popup-more .area_contents').css('overflow', 'hidden');
    //already created Slick. (subDetail.1.0.js)
    renderOptionSubImage(optionNo);
}

var hideOptionPop = function () {
    $('.popup-mask').hide();
    $('.btn_prev').off('click');
    $('.btn_next').off('click');
    $('html,body').removeClass('ovfHiden');
    $("html,body").scrollTop(scrollTop);
    if (!isPC()) {
        $('.wrap.mobile').show();
        $('#footer').show();
        $('body').css('position', '');
    }
    $('.option-slider').slick('slickRemove', null, null, true);
}

var shareSNS = function (flag) {
    const kakaoKey = '195070d849760ede1b5f266967c71bd9';
    let pName = product.baseInfo.productName + ' | ';
    if (product.brand) {
        pName = pName + product.brand.name;
    }
    pName += ' | shop by';
    var fullUrl = '';
    if (flag === 'F') {
        // facebook
        fullUrl = 'https://www.facebook.com/sharer/sharer.php?u=' + encodeURIComponent(window.location);
        window.open(fullUrl, 'facebookShare', 'status=0, scrollbars=no, location=0, menubar=0, width=600px, height=300px');
    } else if (flag === 'T') {
        // twitter
        var param = 'text=' + encodeURIComponent(pName) + '&url=' + encodeURIComponent(window.location);
        fullUrl = 'http://twitter.com/share?' + param;
        window.open(fullUrl, 'twitterShare', 'width=900, height=500, scrollbars=yes, menubar=no');
    } else if (flag === 'P') {
        // pinterest
        var param = 'url=' + encodeURIComponent(window.location) + '&media=' + this.product.baseInfo.imageUrls[0] + '&description=' + pName;
        fullUrl = 'http://pinterest.com/pin/create/button/?' + param;
        window.open(fullUrl, 'pinterestShare', 'width=900, height=500, scrollbars=yes, menubar=no');
    } else if (flag === 'K') {
        var imageUrl = '';
        if (product.baseInfo.imageUrls && product.baseInfo.imageUrls.length > 0) {
            imageUrl = product.baseInfo.imageUrls[0];
        }

        const obj = {};
        obj.objectType = 'commerce';
        obj.content = {
            title: pName,
            imageUrl: imageUrl,
            link: {
                webUrl: encodeURIComponent(window.location)
            }
        };
        var discountRate = Math.round(((product.price.additionDiscountAmt + product.price.immediateDiscountAmt) / product.price.salePrice) * 100) || 0;
        obj.commerce = {
            regularPrice: product.price.salePrice,
            discountPrice: product.price.salePrice - product.price.additionDiscountAmt - product.price.immediateDiscountAmt,
            discountRate: discountRate
        };

        Kakao.cleanup();
        Kakao.init(kakaoKey);
        Kakao.Link.sendDefault(obj);
    } else if (flag === 'KS') {
        Kakao.cleanup();
        Kakao.init(kakaoKey);
        // Kakao.Story.cleanup();
        if (isPC()) {
            Kakao.Story.share({
                url: encodeURIComponent(window.location),
                text: pName
            });
        } else {
            Kakao.Story.open({
                url: encodeURIComponent(window.location),
                text: pName
            });
        }
    }
}

$(document).ready(function () {

    $('.con-goods').show();
    $('.con-service').hide();
    $('.con-consultation').hide();
    $('.purchase-guide').hide();

    shop.product.getDetail(productNo, renderDetail);
    shop.product.getOption(productNo, renderOption);

    shop.coupon.fetchProductCoupon(productNo, function (res) {
        var items = [];
        for (var i = 0; i < res.length; i++) {
            var aCoupon = res[i];
            if (aCoupon.couponType === 'CART') {
                if (aCoupon.useConstraint.minSalePrice && aCoupon.useConstraint.maxSalePrice) {
                    aCoupon.constraintDisplay = 1;
                } else if (aCoupon.useConstraint.minSalePrice && !aCoupon.useConstraint.maxSalePrice) {
                    aCoupon.constraintDisplay = 2;
                } else if (!aCoupon.useConstraint.minSalePrice && aCoupon.useConstraint.maxSalePrice) {
                    aCoupon.constraintDisplay = 3;
                }
                items.push(aCoupon);
            }
        }

        $('#coupon-template').renderTemplate({ "items": items }, "#coupons");

    });
    shop.product.fetchReview(productNo, renderReview);
    shop.product.fetchInquiry(productNo, renderInquiry);

    if (shop.isLogin()) {
        shop.product.getReviewAbleProducts(productNo, function (obj) {
            $('#formReview').show();
            $('#formReview input[name=optionNo]').val(obj.optionNo);
            $('#formReview input[name=orderOptionNo]').val(obj.orderOptionNo);
        });
    }

    $('body').bind('click', function (e) {
        var target = $(e.target);
        if (target.hasClass('txt_select_1') === false && target.parent().parent().hasClass('lst_sub_option') === false) {
            $('.txt_select_1').removeClass('on');
        }
    });

    $('body').bind('touchend', function (e) { //mobile
        var target = $(e.target);
        if (target.hasClass('txt_select_1') === false && target.parent().parent().hasClass('lst_sub_option') === false) {
            $('.txt_select_1').removeClass('on');
        }
    });
});

shop.product = {

    ready: function (productNo) {

    },

    getDetail: function (productNo, callback) {
        shop.ajax({
            url: deployInfo.apiUrl + '/products/' + productNo,
            type: 'GET',
            data: null,
            success: $.proxy(function (res) {
                product = res;
                if (product.baseInfo.optionImageViewable) {
                    shop.product.getOptionMainImage(productNo, renderOptionMainImage);
                }
                callback(res);
            }, this)
        });
    },
    getProduct: function () {
        return product;
    },
    getReviewAbleProducts: function (productNo, callback) {
        shop.ajax({
            url: deployInfo.apiUrl + '/profile/order-options/product-reviewable',
            type: 'GET',
            data: null,
            success: $.proxy(function (res) {
                var items = res.items;
                for (var i = 0; i < items.length; i++) {
                    var item = items[i];
                    if (String(item.productNo) === productNo) {
                        var review = {};
                        review.optionNo = item.optionNo;
                        review.orderOptionNo = item.orderOptionNo;
                        callback(review);
                        break;
                    }
                }
            }, this)
        });
    },

    getOption: function (productNo, callback) {
        shop.ajax({
            url: deployInfo.apiUrl + '/products/' + productNo + '/options/',
            type: 'GET',
            data: null,
            success: $.proxy(function (res) {
                options = res.flatOptions;
                var name = res.labels[0];
                callback(name, options);
            }, this)
        });
    },

    getOptionMainImage: function (productNo, callback) {
        shop.ajax({
            url: deployInfo.apiUrl + '/products/' + productNo + '/options/images',
            type: 'GET',
            data: null,
            success: $.proxy(function (res) {
                optionMainImages = res;
                optionSubImages = [];
                for (var i = 0; i < optionMainImages.length; i++) {
                    var optionMainImage = optionMainImages[i];
                    shop.product.getOptionSubImages(productNo, optionMainImages[i].optionNo);
                }
                callback(optionMainImages);
            }, this)
        });
    },

    getOptionSubImages: function (productNo, optionNo) {
        shop.ajax({
            url: deployInfo.apiUrl + '/products/' + productNo + '/options/' + optionNo + '/images',
            type: 'GET',
            data: null,
            success: $.proxy(function (res) {
                var optionImages = [];
                for (var i = 0; i < res.length; i++) {
                    optionImages.push(res[i].imageUrl);
                }
                var subImage = {};
                subImage.optionNo = optionNo;
                subImage.images = optionImages;
                optionSubImages.push(subImage);
            }, this)
        });
    },

    fetchInquiry: function (productNo, callback) {
        shop.ajax({
            url: deployInfo.apiUrl + '/products/' + productNo + '/inquiries?' + $.param(inquiryPageInfo),
            type: 'GET',
            data: null,
            success: $.proxy(function (res) {
                var items = res.items;
                var totalCnt = res.totalCount;
                if (items.length != 0) {
                    inquiryPageInfo.pageNumber += 1;
                    productInfo.inquiry = $.merge(productInfo.inquiry, items);
                }

                callback(productInfo.inquiry, totalCnt);
            }, this)
        });
    },

    reFetchInquiry: function (productNo, callback) {

        var pageSize = 0;
        if (productInfo.inquiry.length == 0) {
            pageSize = 1;
        } else if (productInfo.inquiry.length > 0 && productInfo.inquiry.length < 10) {
            pageSize = productInfo.inquiry.length + 1;
        } else {
            pageSize = 10
        }
        inquiryPageInfo.pageNumber = 1;
        var page = {};
        page.pageNumber = 1;
        page.pageSize = pageSize;
        page.hasTotalCount = true;
        page.isMyInquiries = false;
        shop.ajax({
            url: deployInfo.apiUrl + '/products/' + productNo + '/inquiries?' + $.param(page),
            type: 'GET',
            data: null,
            success: $.proxy(function (res) {
                var items = res.items;
                var totalCnt = res.totalCount;
                productInfo.inquiry = items;
                if (items.length != 0) {
                    inquiryPageInfo.pageNumber += 1;
                }
                callback(productInfo.inquiry, totalCnt);
            }, this)
        });
    },

    getInquiry: function (index) {
        return productInfo.inquiry[index];
    },

    addInquiry: function (productNo, param, callback) {
        shop.ajax({
            url: deployInfo.apiUrl + '/products/' + productNo + '/inquiries',
            type: 'POST',
            data: param,
            success: $.proxy(function (res) {
                callback();
            }, this)
        });
    },

    putInquiry: function (inquiryNo, param, callback) {
        shop.ajax({
            url: deployInfo.apiUrl + '/products/inquiries/' + inquiryNo,
            type: 'PUT',
            data: param,
            success: $.proxy(function (res) {
                callback();
            }, this)
        });
    },

    deleteInquiry: function (inquiryNo, callback) {
        shop.ajax({
            url: deployInfo.apiUrl + '/products/inquiries/' + inquiryNo,
            type: 'DELETE',
            data: null,
            success: $.proxy(function (res) {
                callback();
            }, this)
        });
    },

    fetchReview: function (productNo, callback) {
        shop.ajax({
            url: deployInfo.apiUrl + '/products/' + productNo + '/product-reviews?' + $.param(reviewPageInfo),
            type: 'GET',
            data: null,
            success: $.proxy(function (res) {
                var items = res.items;
                var totalCnt = res.totalCount;
                if (items && items.length != 0) {
                    reviewPageInfo.pageNumber += 1;
                    productInfo.review = $.merge(productInfo.review, items);
                    $.each(items, function(idx, value){
                        reviewImgSrcAll.push({'reviewNo':value.reviewNo, 'fileUrls':value.fileUrls});
                    })
                } else {

                }
                callback(productInfo.review, totalCnt);
            }, this)
        });
    },

    reFetchReview: function (productNo, callback) {

        var pageSize = 0;
        if (productInfo.review.length == 0) {
            pageSize = 1;
        } else if (productInfo.review.length > 0 && productInfo.review.length < 10) {
            pageSize = productInfo.review.length + 1;
        } else {
            pageSize = 10
        }

        var page = {};
        page.pageNumber = 1;
        page.pageSize = pageSize;
        page.hasTotalCount = true;
        page.isMyInquiries = false;
        page["order.by"] = 'RECOMMEND';
        shop.ajax({
            url: deployInfo.apiUrl + '/products/' + productNo + '/product-reviews?' + $.param(page),
            type: 'GET',
            data: null,
            success: $.proxy(function (res) {
                var items = res.items;
                var totalCnt = res.totalCount;
                productInfo.review = items;
                refetchReviewImgSrcAll.length = 0;
                $.each(items, function(idx, value){
                    refetchReviewImgSrcAll.push({'reviewNo':value.reviewNo, 'fileUrls':value.fileUrls});
                })
                callback(productInfo.review, totalCnt);
            }, this)
        });
    },

    getReview: function (index) {
        return productInfo.review[index];
    },

    addReview: function (param, callback) {
        shop.ajax({
            url: deployInfo.apiUrl + '/products/' + param.productNo + '/product-reviews',
            type: 'POST',
            data: param,
            success: $.proxy(function (res) {
                inquiryPageInfo.pageNumber = 1;
                callback();
                //this.fetchInquiry(param.productNo);
            }, this)
        });
    },

    putReview: function (productNo, reviewNo, param, callback) {
        shop.ajax({
            url: deployInfo.apiUrl + '/products/' + productNo + '/product-reviews/' + reviewNo,
            type: 'PUT',
            data: param,
            success: $.proxy(function (res) {
                callback();
            }, this)
        });
    },

    deleteReview: function (productNo, reviewNo, callback) {
        shop.ajax({
            url: deployInfo.apiUrl + '/products/' + productNo + '/product-reviews/' + reviewNo,
            type: 'DELETE',
            data: null,
            success: $.proxy(function (res) {
                callback();
            }, this)
        });
    },

    uploadImage: function (callback) {

        var header = {};

        header.platform = shop.getPlatform();
        header.accessToken = shop.getAccessToken();
        // opt.header.accessToken = 'accessToken';
        header.clientId = deployInfo.clientId;
        header.Version = '1.0';

        var formData = new FormData();
        formData.append('file', $('#fileInput')[0].files[0]);
        $.ajax({
            url: deployInfo.apiUrl + '/files/images',
            type: 'POST',
            data: formData,
            contentType: false,
            processData: false,
            cache: false,
            headers: header,
            success: function (data) {
                callback('success', data.imageUrl);
            },
            error: function (jqXHR) {
                console.log(JSON.stringify(jqXHR));
            }
        });
    },

    addToLocalCart: function (items, callback) {
        var cart = JSON.parse(window.localStorage.cartInfo || '[]');

        var newItems = [];
        for (var i = 0; i < items.length; i++) {
            /*var exist = false;
            for (var j = 0; j < cart.length; j++) {
                if (cart[j].productNo == items[i].productNo && cart[j].optionNo == items[i].optionNo) {
                    cart[j].orderCnt = items[i].orderCnt;
                    exist = true;
                    break;
                }
            }*/
            // if (!exist) {
                newItems.push(items[i]);
            // }
        }
        cart = newItems.concat(cart);
        for (var k = 0; k < cart.length; k++) {
            cart[k].cartNo = k;
        }
        // window save
        window.localStorage.cartInfo = JSON.stringify(cart);
        callback();
    },

    addToRemoteCart: function (carts, callback) {
        shop.ajax({
            url: deployInfo.apiUrl + '/cart?integrated=' + false,
            type: 'POST',
            //   traditional: true,
            data: carts,
            success: function (data, status) {
                callback();
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                var msg = $.parseJSON(XMLHttpRequest.responseText);
                alert(msg.message);
            }
        })
    },

    buy: function (product, callback) {

        var request = {};
        request.cartNos = [0];
        request.products = product;
        request.productCoupons = null;
        request.trackingKey = null;

        shop.ajax({
            url: deployInfo.apiUrl + '/order-sheets',
            type: 'POST',
            data: request,
            success: function (data, status) {
                callback(data.orderSheetNo);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                var msg = $.parseJSON(XMLHttpRequest.responseText);
                alert(msg.message);
            }
        });
    },
};
function showImagePopup(src, reviewNo) {
    $('.popup-mask').show();
    $('.popup-mask strong').text('후기 이미지 자세히 보기');
    $('.more_name').remove();
    $('.img-cnt .first').text('1');
    scrollTop = 0;
    scrollTop = $("html,body").scrollTop();
    $('html,body').addClass('ovfHiden');
    if (!isPC()) {
        $('.wrap.mobile').hide();
        $('#footer').hide();
    }

    var reviewImgSrc = [];
    var idx = 0;
    while (idx < reviewImgSrcAll.length) {
        if (reviewImgSrcAll[idx].reviewNo == reviewNo) {
            reviewImgSrc = reviewImgSrcAll[idx].fileUrls;
            break;
        }
        idx++;
    }

    idx = 0;
    if (refetchReviewImgSrcAll.length > 0) {
        while (idx < refetchReviewImgSrcAll.length) {
            if (refetchReviewImgSrcAll[idx].reviewNo == reviewNo) {
                reviewImgSrc = refetchReviewImgSrcAll[idx].fileUrls;
                break;
            }
            idx++;
        }
    }

    var i = 0;
    var imgCnt = -1;
    while (imgCnt < reviewImgSrc.length) {
        if (reviewImgSrc[i] == src) {
            imgCnt = 0;
        }
        if (imgCnt >= 0) {
            var html = '<div style="outline:none;"><p><span>';
            html += '<img src="' + reviewImgSrc[i] + '" alt="">';
            html += '</span></p></div>';
            // $('.option-slider').append(html);
            $('.option-slider').slick('slickAdd', html);
            imgCnt++;
        }

        i++;
        if (i == reviewImgSrc.length) {
            i = 0;
        }
    }
    $.each($('.option-slider').find('img'), function(idx){
        sliderResize(idx, 'productOptionImg');
    });
    //already created Slick. (subDetail.1.0.js)
    reviewImgPage(imgCnt);
}

var hideImagePopup = function () {
    $('.popup-mask').hide();
    $('html,body').removeClass('ovfHiden');
    $("html,body").scrollTop(scrollTop);
    if (!isPC()) {
        $('.wrap.mobile').show();
        $('#footer').show();
    }
    $('.option-slider').slick('slickRemove', null, null, true);
}

var reviewImgPage = function (imgTotal) {
    //var imgTotal = $('.goods-list .re_image').length;
    if (imgTotal == 1) {
        $('.popup-more .area_contents button').hide();
        $('.img-cnt').hide();
    } else {
        $('.popup-more .area_contents button').show();
        $('.img-cnt').show();
    }
    $('.img-cnt .total').text('/' + imgTotal);
    $('.btn_prev').on('click', function(){
        var nowPage = (parseInt($('.img-cnt .first').text()) - 1);
        if (nowPage == 0) nowPage = imgTotal;
        $('.img-cnt .first').text(nowPage);
    })
    $('.btn_next').on('click', function(){
        var nowPage = parseInt($('.img-cnt .first').text()) + 1;
        if (nowPage > imgTotal) nowPage = 1;
        $('.img-cnt .first').text(nowPage);
    })
}

var setTotalPrice = function () {
    var totalProductPrice = 0;
    $('div[id^="opBox-"]').each(function (index) {
        totalProductPrice += $(this).find('input[id^="op-buyPrice-"]').val() * $(this).find('[id^="orderCnt-"]').val();
    });
    $('div.total-wrap > span').text(formatCurrency(totalProductPrice));
}

var setTotalOptionPrice = function (optionNo,orderCnt) {
    var optionPrice = $('#op-buyPrice-' + optionNo).val();
    $('#opBox-' + optionNo).find('.price-text').text(formatCurrency(optionPrice * orderCnt)+'원');
}

var multiOptionDel = function (optionNo) {
    $('#opBox-'+optionNo).remove();
    setTotalPrice();
}

var validateMultiOption = function (optionNo) {
    var selectedOption = undefined;
    var buyCnt = Number($('#orderCnt-' + optionNo).val());
    for (var i = 0; i < options.length; i++) {
        if (options[i].optionNo == Number(optionNo)) {
            selectedOption = options[i];
        }
    }

    if (selectedOption.stockCnt === 0) {
        ValidateFailed('선택하신 옵션이 품절되었습니다.')
        return false;
    }
    if (buyCnt > selectedOption.stockCnt) {
        ValidateFailed('상품의 재고가 부족합니다. 수량을 다시 확인 해 주세요.')
        return false;
    }
    return true;
}
