'use strict';

if (deployInfo.profile === 'release' || deployInfo.profile === 'beta') {
    document.write('<script type="text/javascript" src="https://pay.kcp.co.kr/plugin/payplus_web.jsp"></script>');
    document.write('<script type="text/javascript" src="https://xpayvvip.uplus.co.kr/xpay/js/xpay_crossplatform.js" charset="UTF-8"></script>');
} else {
    document.write('<script type="text/javascript" src="https://testpay.kcp.co.kr/plugin/payplus_web.jsp"></script>');
    document.write('<script type="text/javascript" src="https://pretest.uplus.co.kr:9443/xpay/js/xpay_crossplatform.js" charset="UTF-8"></script>');
}

var orderSheetNo = null;
var addressInfoAll = [];
var addressInfo = null;
var addressInfoOrder = null;
var paymentAmt = null;
var cartCouponAmt = 0;
var promotionCode = '';
var cartCouponIssueNo = '';
var requireCustomsIdNumber = false;
var globalCurrentPage = 1;
var tradeBankAccountInfo = null;

var isGuest = false;

var guestDefaultAddress = {
    ordererName: '',
    telinfo: [],
    ordererEmail: '',
    contactExist: true
}

var memberJoinSuccess = false;
var memberLoginSuccess = false;
var tmpOrderData = {};
var tmpConfirmUrl = null;
var titleProductName = null;
var setPgType = null;
$(function () {
    scriptLoad();
    shop.order.ready();
})

function scriptLoad() {
    var url = deployInfo.apiUrl + '/payments/' + deployInfo.payJs;
    const script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = url;
    script.async = true;
    document.body.appendChild(script);
}

shop.order = {
    ready: function () {
        this.getOrderSheetNo();
        if (orderSheetNo != null) {
            this.init();
        } else {
            this.gotoError();
        }
    },
    init: function () {
        this.isGuest();
        this.getOrder();
        if (!isGuest) {
            this.getCoupon();
            $('body').on('click', '#couponApply', $.proxy(this.searchCoupon, this));
        }
    },
    attachEvent: function () {
        $('#same').on('change', this.sameChange);
        $('#searchPopUp,#searchPopUpOrder').on('click', this.openAddressesPopup);
        $('#closeBtn').on('click', this.closeAddressesPopup);
        $('#buttonRetry').on('click', $.proxy(this.memberJoinRetry, this));
        $('#buttonNext').on('click', $.proxy(this.guestReserve, this));
        $('#closeErrorBtn').on('click', this.closeErrorPopup);
        $('body').on('click', '#searchAddressBtn', $.proxy(this.searchAddresses, this));
        $('body').on('keydown', '#kword', $.proxy(this.searchAddressesWithEnter, this));
        $('body').on('click', '#payBtn', $.proxy(this.pay, this));
        $('.js-more-view').on('click',function(){
            $('.js-delivery-info').show();
            $('.js-more-view').hide();
            $('.js-more-hide').show();
            $('.agree_check_box').css('top','0px');
        });
        $('.js-more-hide').on('click',function(){
            $('.js-delivery-info').hide();
            $('.js-more-view').show();
            $('.js-more-hide').hide();
            $('.js-more-view').focus();
            $('.agree_check_box').css('top','-110px');
        });
        $('#orderMemberJoin').on('click',function(){
            $('.ordererEmail-error').remove();
            $('.ordererName-error').remove();
            if($(this).is(':checked')){
                $('.beforeJoinInfo').hide();
                $('.afterJoinInfo').show();
                $('#useTerm').text(deployInfo.mallName + ' 이용약관');

                var namePattern = /[^a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣\u119E\u11A2]/;
                if (!/\S+/.test($('#ordererName').val())) {
                    getErrorMessage('ordererName','이름을 입력해주세요.');
                }else if ($('#orderMemberJoin').is(':checked') && namePattern.test($('#ordererName').val())) {
                    getErrorMessage('ordererName', '한글, 영문만 입력 가능합니다.');
                }

                if (!/\S+/.test($('#ordererEmail').val())) {
                    getErrorMessage('ordererEmail','이메일을 입력해주세요');
                }else if(!/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/.test($('#ordererEmail').val())) {
                    getErrorMessage('ordererEmail','이메일 형식을 확인 해주세요.');
                }else if( !shop.order.getEmailExist()){
                    //$('#ordererEmail').focus();
                }

            }else{
                $('.beforeJoinInfo').show();
                $('.afterJoinInfo').hide();
            }
        });
        $('input[name=cashReceiptIssuePurposeType]').on('click',function(){
            var cashReceiptKeyValue = $('#cashReceiptKey').val();
            if($(this).val() == 'INCOME_TAX_DEDUCTION'){
                $('#cashReceiptKey').attr('maxlength',11);
                $('#cashReceiptKey').val(cashReceiptKeyValue.substr(0,11));
            }else{
                $('#cashReceiptKey').attr('maxlength',10)
                $('#cashReceiptKey').val(cashReceiptKeyValue.substr(0,10));
            }
        });
        $('input[name=applyCashReceipt]').on('click',function(){
            if($(this).val() == 'y'){
                $('.receipt_type').show();
            }else{
                $('.receipt_type').hide();
            }
        });
        $('input[name=cashReceiptIssuePurposeType]').on('click',function(){
            if($(this).val() == 'INCOME_TAX_DEDUCTION'){
                $('.casher-user-info').text('휴대폰번호');
            }else{
                $('.casher-user-info').text('사업자번호');
            }
        });
        $("input[name='mode']").on('click',function(){
            if($(this).val() == 'ACCOUNT'){
                $('.easy_account_tb').show().prev().show();
            }else{
                $('.easy_account_tb').hide().prev().hide();
            }
        });
    },
    getOrderSheetNo: function () {
        orderSheetNo = shop.getUrlParam('ordersheetno');
    },
    isGuest: function () {
        if (shop.getAccessToken() == '' || shop.getAccessToken() == null || shop.getAccessToken() == undefined) {
            isGuest = true;
            return;
        }
        isGuest = false;
    },
    getOrder: function () {
        shop.ajax({
            url: deployInfo.apiUrl + '/order-sheets/' + orderSheetNo + '?includeMemberAddress=' + true,
            type: 'GET',
            data: null,
            success: $.proxy(function (res) {

                titleProductName = res.deliveryGroups[0].orderProducts[0].productName;
                titleProductName = stringCut(titleProductName,30);

                // productList
                var deliveryGroups = res.deliveryGroups;
                $('#deliveryGroups-template').renderTemplate({"deliveryGroups": deliveryGroups}, "#tb");

                if (res.orderSheetAddress && res.orderSheetAddress.mainAddress) {
                    addressInfoOrder = addressInfo = res.orderSheetAddress.mainAddress;
                }

                if (!isGuest) {
                    // address
                    var ordererContact = res.ordererContact;
                    ordererContact.telinfo = ordererContact.ordererContact1;
                    //ordererContact.contactExist = ordererContact.ordererContact1 != null;

                    addressInfo = res.orderSheetAddress.mainAddress;

                    if (res.orderSheetAddress && res.orderSheetAddress.memberAddress) {
                        var memberAddressInfo = res.orderSheetAddress.memberAddress;
                        addressInfo.receiverAddress = memberAddressInfo.address;
                        addressInfo.receiverJibunAddress = memberAddressInfo.jibunAddress;
                        addressInfo.receiverDetailAddress = memberAddressInfo.detailAddress;
                        addressInfo.receiverZipCd = memberAddressInfo.zipCd;
                        addressInfoOrder = addressInfo;
                    }

                    $('#address').render({
                        "ordererContact": ordererContact,
                        "addressInfo": addressInfo,
                    });

                    // cartCouponAmt
                    $('#cartCouponAmt').render({"cartCouponAmt": res.paymentInfo.cartCouponAmt});

                    // couponinfo for cal
                    if (res.appliedCoupons != null) {
                        cartCouponIssueNo = res.appliedCoupons.cartCouponIssueNo;
                        promotionCode = res.appliedCoupons.promotionCode
                    }

                    $("#password1").hide();
                    $("#password2").hide();
                    $("#password3").hide();
                    $("#password4").hide();
                    $('.js-memberJoin').hide();

                } else {
                    /*
                    $("#address").find("input").each(function () {
                        $(this).removeAttr('readonly');
                    });
                    */
                    $("#payLeft").hide();
                    $('.js-memberUpdate').hide();
                    $('#address').render({"ordererContact": guestDefaultAddress});

                }
                $('#accountPayment').hide();
                // customsIdNumber
                requireCustomsIdNumber = res.requireCustomsIdNumber;

                $('#newAddress').render({
                    "requireCustomsIdNumber": requireCustomsIdNumber,
                    "addressInfo": addressInfo,
                    //"mobileNo": mobileNo,
                    "ordererContact": ordererContact,

                });

                // agreement
                var agreetypes = agreeTypesFlag(res.agreementTypes);
                var sellerList = getSellerList(res.deliveryGroups);
                $('#agree').render({
                    "agreetypes": agreetypes,
                    "sellerList": sellerList,
                    "foreignPartners": res.foreignPartners
                });
                deployInfo.bindAgreements($('#memberPrivacy'), 'memberPrivacy');
                deployInfo.bindAgreements($('#nonMemberPrivacy'), 'nonMemberPrivacy');

                // paymentAmt
                paymentAmt = res.paymentInfo.paymentAmt;

                // totalPriceArea
                this.setPriceArea(this.getTotalPrice(res.paymentInfo));

                var payTypeCheck = [];
                $(res.availablePayTypes).each(function(i, e){
                    payTypeCheck.push(e.payType);

                    //설정PG사 확인
                    if(e.payType == 'CREDIT_CARD'){
                        for(var k=0; k<e.pgTypes.length; k++){
                            if(e.pgTypes[k] != 'PAYCO'){
                                setPgType = e.pgTypes[k];
                            }
                        }
                    }
                });

                if($.inArray('PAYCO',payTypeCheck)>=0){
                    $('#PAYCO').show();
                    $("input:radio[name='mode']:input[value='payco']").prop("checked", true);
                }else{
                    $('#simplePayment').hide();
                    $('#PAYCO').hide();
                    if($.inArray('CREDIT_CARD',payTypeCheck)>=0) {
                        $("input:radio[name='mode']:input[value='CREDIT_CARD']").prop("checked", true);
                    }
                }
                if($.inArray('ESCROW_REALTIME_ACCOUNT_TRANSFER',payTypeCheck)>=0 || $.inArray('ESCROW_VIRTUAL_ACCOUNT',payTypeCheck)>=0 ){
                    $('.js-escrow').show();
                }else{
                    $('.js-escrow').hide();
                }
                if($.inArray('CREDIT_CARD',payTypeCheck)>=0){
                    $('#CREDIT_CARD').show();
                }else{
                    $('#CREDIT_CARD').hide();
                }
                if($.inArray('REALTIME_ACCOUNT_TRANSFER',payTypeCheck)>=0){
                    $('#REALTIME_ACCOUNT_TRANSFER').show();
                }else{
                    $('#REALTIME_ACCOUNT_TRANSFER').hide();
                }
                if($.inArray('VIRTUAL_ACCOUNT',payTypeCheck)>=0){
                    $('#VIRTUAL_ACCOUNT').show();
                }else{
                    $('#VIRTUAL_ACCOUNT').hide();
                }
                if($.inArray('ACCOUNT',payTypeCheck)>=0){
                    $('#ACCOUNT').show();
                }else{
                    $('#ACCOUNT').hide();
                }

                $('.js-delivery-info').find('input').css('background-color','#eeeeee').attr("readonly",true);

                tradeBankAccountInfo = res.tradeBankAccountInfos[0];
                if(tradeBankAccountInfo){
                    if(tradeBankAccountInfo.bankAccount == '000-000-0000' && tradeBankAccountInfo.bankDepositorName == '임시'){
                        var tradeBankAccountInfoText = '';
                    }else{
                        var tradeBankAccountInfoText = tradeBankAccountInfo.bankName + "  " +  tradeBankAccountInfo.bankAccount + "  " + tradeBankAccountInfo.bankDepositorName;
                    }

                    $('.js-tradeBankAccountInfo').text(tradeBankAccountInfoText);
                }
                if(res.applyCashReceiptForAccount === false){
                    $('.receipt_provide').hide();
                }
                $("input:text[numberOnly]").on("keyup", function() {
                    $(this).val($(this).val().replace(/[^0-9]/g,""));
                });

                if(shop.getPlatform() == 'MOBILE_WEB'){
                    $('.js-delivery-info').hide();
                    $('.agree_check_box').css('top','-110px');
                    $('.deliveryTitle').hide();
                }

                this.attachEvent();
                this.validInit();
                this.inputMask();

            }, this),
            error: $.proxy(function (jqXHR, textStatus, errorThrown) {
                var result = JSON.parse(jqXHR.responseText);
                alert(result.message);
                console.log("jqXHR : ", jqXHR);
                console.log("textStatus : ", textStatus);
                console.log("errorThrown : ", errorThrown);

                this.gotoError();
            }, this)
        });
    },
    gotoError: function () {
        var nextUrl = './order.html?ordersheetno=' + orderSheetNo;
        var cartNos = shop.getUrlParam('cartnos');
        if (cartNos != null) {
            nextUrl += '&cartNos=' + cartNos;
        }
        location.href = './errordata.html?nextUrl=' + nextUrl;
    },
    getCoupon: function () {
        shop.ajax({
            url: deployInfo.apiUrl + '/order-sheets/' + orderSheetNo + '/coupons',
            type: 'GET',
            data: null,
            success: $.proxy(function (res) {
                $('#coupons-template').renderTemplate({"coupons": res.cartCoupons}, "#couponList");

                // select onchange
                $('body').on('change', '#couponList', $.proxy(this.changeCoupon, this));
            }, this)
        });
        // this.callCouponApply({
        //     cartCouponIssueNo:$('#couponList').val() ,
        //     promotionCode:$('#promotionCode').val()
        // })
    },
    setPriceArea: function (price) {
        if(price.remoteDeliveryAmt > 0){
            $('.remoteDeliveryAmt.pc-visible').html('<br><span>지역별 추가배송비</span><strong>' + shop.order.formatNumber(price.remoteDeliveryAmt) + '원</strong>');
            $('.remoteDeliveryAmt.m-visible').html(' (지역별 추가배송비:'+ shop.order.formatNumber(price.remoteDeliveryAmt) + '원)');
            alert('지역별 추가배송비가 부과됩니다. 구매 전 확인 부탁드립니다.');
        }else{
            $('.remoteDeliveryAmt').html('');
        }
        $('#totalPrice').render({'totalPrice': price});
    },
    formatNumber: function (num) {
        var str = 0;
        if (num) {
            str = String(num.toFixed(0));
            str = str.replace(/(\d)(?=(\d{3})+$)/g, '$1,');
        }
        return str;
    },
    sameChange: function () {
        if ($('#same').is(':checked')) {
            $('#newAddressName').val($('#ordererName').val());
            $('#newAddressContact').val($('#ordererContact').val());
            $('#addressFromPop').val($('#addressFromPopOrder').val());
            $('#addressFromInput').val($('#addressFromInputOrder').val());
            $('#postcodeFromPop').val($('#postcodeFromPopOrder').val());
            $('.js-delivery-info').find('input').css('background-color','#eeeeee').attr("readonly",true);
            if(addressInfoOrder){
                addressInfo = addressInfoOrder;
            }
        } else {
            $('#newAddressName').val('');
            $('#newAddressContact').val('');
            $('#addressFromPop').val('');
            $('#addressFromInput').val('');
            $('#postcodeFromPop').val('');
            $(".js-delivery-info").find("input").each(function () {
                $(this).css('background-color','');
                if($(this).attr("id") == 'postcodeFromPop' || $(this).attr("id") == 'addressFromPop'){

                }else{
                    $(this).removeAttr('readonly');
                }
            });
            if(shop.getPlatform() == 'MOBILE_WEB'){
                $('.js-delivery-info').show();
                $('.js-more-view').hide();
                $('.js-more-hide').show();
                $('.agree_check_box').css('top', '0px');
            }
            addressInfo =  null;
        }

        shop.order.calWithAddress();

    },
    openAddressesPopup: function (e) {
       $('#searchPopTarget').val(e.target.getAttribute('popup-target'));
       if(!$('#same').is(':checked') || e.target.getAttribute('popup-target') == 'order' ){
            $('#addressesPopup').show();
       }
    },
    closeAddressesPopup: function () {
        $('#searchResult').html('').hide();
        $('#kword').val('');
        $('#addressesPopup').hide();
    },
    openErrorPopup: function () {
        $('#errorPopup').show();
    },
    closeErrorPopup: function () {
        $('#errorPopup').hide();
    },
    memberJoinRetry: function () {
        if(!memberJoinSuccess && !memberLoginSuccess){
            this.memberJoin();
        }else if(memberJoinSuccess && !memberLoginSuccess){
            this.logIn();
        }
    },
    guestReserve: function () {
        this.reservetion(tmpOrderData,tmpConfirmUrl);
    },
    searchAddressesWithEnter: function (e) {
        if (e.keyCode == 13) {
            this.searchAddresses();
        }
    },
    searchAddresses: function () {
        var keyword = $('#kword').val();
        if (!keyword || !keyword.trim()) {
            alert('검색어를 입력해주세요.')
            return false;
        }
        ;
        this.pageChange(1, keyword);
    },
    pageChange: function (page, keyword) {
        const params = {
            keyword: keyword,
            pageNumber: page,
            pageSize: 5,
            hasTotalCount: true
        };

        const queryStr = Object.keys(params)
            .map(function (key) {
                return key + "=" + encodeURIComponent(params[key])
            })
            .join('&');

        shop.ajax({
            url: deployInfo.apiUrl + '/addresses/search?' + queryStr,
            type: 'GET',
            data: null,
            success: $.proxy(function (res) {
                var startIdx = this.getStartIdx(params.pageNumber, params.pageSize);
                var endIdx = Math.min(startIdx + params.pageSize, Math.ceil(res.totalCount / 10) + 1)
                var indexs = this.range(startIdx, endIdx);
                globalCurrentPage = params.pageNumber;

                var result = {
                    items: res.items,
                    totalCount: res.totalCount,
                    indexs: indexs,
                    keyword: params.keyword
                }

                // pagination
                this.prePage(parseInt(params.pageNumber), parseInt(params.pageSize), params.keyword);
                this.nextPage(parseInt(params.pageNumber), parseInt(params.pageSize), params.keyword, res.totalCount);

                this.getAddressInfo(res.items);
                $('#zipSearchResult-template').renderTemplate({"result": result}, "#searchResult");
                $('#searchResult').show();

                $('body').off('click', '#pagination');
                $('body').on('click', '#pagination', $.proxy(this.idxChange, this));
            }, this)
        })
    },
    prePage: function (currentPage, pageTerm, keyword) {
        if (currentPage - pageTerm > 0) {
            var pageNo = this.getStartIdx(currentPage - pageTerm, pageTerm) + pageTerm - 1;
            $('body').off('click', '#prevBtn');
            $('body').on('click', '#prevBtn', $.proxy(this.pageChange, this, pageNo, keyword));
        }
    },
    nextPage: function (currentPage, pageTerm, keyword, totalCount) {
        var nextPage = this.getStartIdx(currentPage + pageTerm, pageTerm);
        if (nextPage <= Math.ceil(totalCount / 10)) {
            $('body').off('click', '#nextBtn');
            $('body').on('click', '#nextBtn', $.proxy(this.pageChange, this, nextPage, keyword));
        }
    },
    getStartIdx: function (currentPage, pageTerm) {
        return Math.floor(currentPage / pageTerm) * pageTerm + (currentPage % pageTerm !== 0 ? 1 : (1 - pageTerm))
    },
    range: function (start, edge, step) {
        if (arguments.length === 1) {
            edge = start
            start = 0
        }

        edge = edge || 0
        step = step || 1

        for (var ret = []; (edge - start) * step > 0; start += step) {
            ret.push(start)
        }
        return ret
    },
    idxChange: function (e) {
        var id = e.target.getAttribute("id");
        if (id != 'pagination' && id != 'prevBtn' && id != 'nextBtn') {
            this.pageChange(e.target.getAttribute('_no'), $('#pagination').attr('_keyword'));
        }
        ;
    },
    searchCoupon: function () {
        var code = $('#promotionCode').val();
        if (!code) {
            alert('쿠폰번호를 입력해주세요.');
            return false;
        }
        $('#couponList').val(0);
        var couponRequest = {
            cartCouponIssueNo: '',
            promotionCode: code
        }
        // search send
        this.sendCoupon(code)
        // apply
        // this.callCouponApply(couponRequest)
    },
    sendCoupon: function (promotionCode) {
        var couponRequest = {
            promotionCode : promotionCode
        }
        shop.ajax({
            url: deployInfo.apiUrl + '/coupons/register-code/' + promotionCode,
            type: 'POST',
            data: couponRequest,
            success: $.proxy(function (res) {
                $('#promotionCode').val('');
                this.getCoupon();
            }, this),
            error: $.proxy(function (error) {
                var res = JSON.parse(error.responseText)
                alert(res.message)
            }, this)
        });
    },
    changeCoupon: function () {
        var issueNo = $('#couponList').val();
        $('#promotionCode').val('');
        var couponRequest = {
            cartCouponIssueNo: issueNo == 0 ? '' : issueNo,
            promotionCode: ''
        }
        // apply
        this.callCouponApply(couponRequest)
    },
    callCouponApply: function(couponRequest) {
        promotionCode = couponRequest.promotionCode;
        cartCouponIssueNo = couponRequest.cartCouponIssueNo;
        shop.ajax({
            url: deployInfo.apiUrl + '/order-sheets/' + orderSheetNo + '/coupons/apply',
            type: 'POST',
            data: couponRequest,
            success: $.proxy(function (res) {
                if (res.appliedCoupons.promotionCode != '') {
                    promotionCode = res.appliedCoupons.promotionCode;
                }
                if (res.appliedCoupons.cartCouponIssueNo != '') {
                    cartCouponIssueNo = res.appliedCoupons.cartCouponIssueNo;
                }

                $('#cartCouponAmt').render({"cartCouponAmt": res.paymentInfo.cartCouponAmt});
                // order cal with address
                this.calWithAddress();
            }, this),
            error: $.proxy(function (error) {
                var res = JSON.parse(error.responseText)
                if (promotionCode && promotionCode !== '') {
                    this.callCouponApply({
                        cartCouponIssueNo: '',
                        promotionCode: ''
                    }, '')
                }
                alert(res.message)
            }, this)
        });
    },
    pay: function () {
        if (!$('#agree-to-buy').is(':checked')) {
            alert("상품 구매에 대한 동의를 하셔야 결제가 가능합니다.");
            return;
        }
        var type = $("input[name='mode']:checked").val();
        if (type == 'payco') {
            this.reserve('PAYCO', 'PAYCO');
        } else if(type == 'ACCOUNT'){
            this.reserve('NONE', 'ACCOUNT');
        } else {
            this.reserve(setPgType, type);
        }
    },
    getAddressInfo: function (items) {
        addressInfoAll = [];
        for (var i = 0; i < items.length; i++) {
            var address = {}
            address.receiverAddress = items[i].address + " " + items[i].detailAddress;
            address.receiverJibunAddress = items[i].jibunAddress + " " + items[i].detailAddress;
            addressInfoAll.push(address);
        }
    },
    calWithAddress: function () {
        if (addressInfo && addressInfo.receiverAddress && addressInfo.receiverJibunAddress) {
            // order cal by address
            var addressRequest = {
                "addressType": "RECENT",
                "countryCd": "KR",
                "customsIdNumber": "",
                "defaultYn": "",
                "receiverAddress": addressInfo.receiverAddress,
                "receiverContact1": "",
                "receiverContact2": "",
                "receiverDetailAddress": addressInfo.receiverDetailAddress,
                "receiverJibunAddress": addressInfo.receiverJibunAddress,
                "receiverName": "string",
                "receiverZipCd": $('#postcodeFromPop').text()
            };
        }else{
            var addressRequest = null
        }

        var couponRequest = {};
        var couponApplyFlag = false;
        if (cartCouponIssueNo != '') {
            couponRequest.cartCouponIssueNo = cartCouponIssueNo;
            couponApplyFlag = true;
        }
        if (promotionCode != '') {
            couponRequest.promotionCode = promotionCode;
            couponApplyFlag = true;
        }

        var data = {};
        if (couponApplyFlag) {
            data.couponRequest = couponRequest;
        }
        data.addressRequest = addressRequest;

        shop.ajax({
            url: deployInfo.apiUrl + '/order-sheets/' + orderSheetNo + '/calculate',
            type: 'POST',
            data: data,
            success: $.proxy(function (res) {
                paymentAmt = res.paymentInfo.paymentAmt;
                this.setPriceArea(this.getTotalPrice(res.paymentInfo));
            }, this)
        })

    },
    getTotalPrice: function (paymentInfo) {
        var totalPrice = {
            totalStandardAmt: paymentInfo.totalStandardAmt,
            totalDiscountAmt: paymentInfo.cartCouponAmt + paymentInfo.totalAdditionalDiscountAmt + paymentInfo.totalImmediateDiscountAmt + paymentInfo.productCouponAmt,
            deliveryAmt: paymentInfo.deliveryAmt,
            remoteDeliveryAmt: paymentInfo.remoteDeliveryAmt,
            paymentAmt: paymentInfo.paymentAmt
        }
        return totalPrice;
    },
    reserve: function (pgType, payType) {
        // order input check
        var receiverName = $('#newAddressName').val();
        var receiverZipCd = $('#postcodeFromPop').val();
        var receiverAddress = $('#addressFromPop').val();
        var receiverDetailAddress = $('#addressFromInput').val();
        var ordererZipCd = $('#postcodeFromPopOrder').val();
        var ordererAddress = $('#addressFromPopOrder').val();
        var ordererDetailAddress = $('#addressFromInputOrder').val();

        var receiverContact = splitValue($('#newAddressContact').val(), '-');
        var customsIdNumber = $('#requireCustomsIdNumber').val();

        var tempPasswordInput = $('#tempPassword').val();
        var oname = $('#ordererName').val();
        var oContact = splitValue($('#ordererContact').val(), '-');
        var oEmail = $('#ordererEmail').val();

        var applyCashReceipt = ($("input[name='applyCashReceipt']:checked").val() == 'y') ? true : false;
        var remitter = $('#remitter').val();
        var cashReceiptIssuePurposeType = $("input[name='cashReceiptIssuePurposeType']:checked").val();
        var cashReceiptKey = $('#cashReceiptKey').val();

        if(payType == 'ACCOUNT' && (typeof tradeBankAccountInfo == 'undefined' || tradeBankAccountInfo == null || tradeBankAccountInfo == '' )) {
            alert('쇼핑몰의 무통장입금 계좌 정보가 설정되어있지 않습니다. \n고객센터로 문의해 주세요.');
            return false;
        }

        if (!/\S+/.test(oname)) {
            $('#ordererName').focus();
            getErrorMessage('ordererName','이름을 입력해주세요.');
            return false;
        }

        var namePattern = /[^a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣\u119E\u11A2]/;
        if ($('#orderMemberJoin').is(':checked') && namePattern.test(oname)) {
            getErrorMessage('ordererName', '한글, 영문만 입력 가능합니다.');
            $('#ordererName').focus();
            return false;
        }

        if (!/\S+/.test(oContact) || oContact.length < 10) {
            $('#ordererContact').focus();
            getErrorMessage('ordererContact','휴대전화번호를 입력해주세요.');
            return false;
        }

        if (!/\S+/.test(ordererZipCd)) {
            $('#searchPopUpOrder').focus();
            getErrorMessage('postcodeFromPopOrder','주소를 입력해주세요.');
            return false;
        }

        if (!/\S+/.test(ordererAddress)) {
            //$('#searchPopUpOrder').focus();
            getErrorMessage('addressFromPopOrder','주소를 입력해주세요.');
            return false;
        }

        /*
        if (!/\S+/.test(ordererDetailAddress)) {
            $('#addressFromInputOrder').focus();
            getErrorMessage('addressFromInputOrder');
            return false;
        }
        */
        if (!/\S+/.test(oEmail)) {
            $('#ordererEmail').focus();
            getErrorMessage('ordererEmail','이메일을 입력해주세요');
            return false;
        }

        if (!/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/.test(oEmail)) {
            $('#ordererEmail').focus();
            getErrorMessage('ordererEmail','이메일 형식을 확인 해주세요.');
            return false;
        }

        if($('#orderMemberJoin').is(':checked') && !this.getEmailExist()){
            $('#ordererEmail').focus();
            return false;
        }
        /*
        if (!/^.*(?=.{8,})(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*? ]).*$/.test(tempPasswordInput)) {
            $('#tempPassword').focus().next().text('주문 비밀번호를 정확하게 입력해주세요.').show();
            return false;
        }
        */
        if (isGuest) {
            var password = tempPasswordInput;
            var alpha = password.search(/[a-zA-Z]/ig);
            var number = password.search(/[0-9]/g);
            var special = password.search(/[!@#$%^&+=-_.()]/);
            var spc_1 = password.search(/[^a-zA-Z0-9!@#$%^&+=-_.()]/);

            if ((alpha < 0 && number < 0) || (alpha < 0 && special < 0) || (number < 0 && special < 0) || password.length < 8) {
                $('#tempPassword').focus();
                getErrorMessage('tempPassword', '비밀번호는 영문, 숫자, 특수문자 중 2가지 조합으로 8~20자로 입력하셔야 합니다.');
                return false;
            }
            if (spc_1 > -1) {
                $('#tempPassword').focus();
                getErrorMessage('tempPassword', '특수문자는 !@#$%^&+=-_.()만 사용 가능합니다.');
                return false;
            }

            if ($('#tempPassword').val() != $('#tempPasswordCheck').val()) {
                $('#tempPasswordCheck').focus();
                getErrorMessage('tempPasswordCheck', '비밀번호와 비밀번호 확인 값이 일치하지 않습니다.');
                return false;
            }
        }

        if (!/\S+/.test(receiverName)) {
            getErrorMessage('newAddressName','이름을 입력해주세요.');
            if(shop.getPlatform() == 'MOBILE_WEB') {
                $('.js-more-view').trigger('click');
            }
            $('#newAddressName').focus();
            return false;
        }


        if (!/\S+/.test(receiverZipCd) && !$('#same').is(':checked')) {
            getErrorMessage('postcodeFromPop','주소를 입력해주세요.');
            if(shop.getPlatform() == 'MOBILE_WEB') {
                $('.js-more-view').trigger('click');
            }
            $('#postcodeFromPop').focus();
            return false;
        }
        if (!/\S+/.test(receiverAddress) && !$('#same').is(':checked')) {
            getErrorMessage('addressFromPop','주소를 입력해주세요.');
            if(shop.getPlatform() == 'MOBILE_WEB') {
                $('.js-more-view').trigger('click');
            }
            $('#addressFromPop').focus();
            return false;
        }
        if ((!/\S+/.test(receiverContact) && !$('#same').is(':checked')) || receiverContact.length < 10) {
            getErrorMessage('newAddressContact','휴대전화번호를 입력해주세요.');
            if(shop.getPlatform() == 'MOBILE_WEB') {
                $('.js-more-view').trigger('click');
            }
            $('#newAddressContact').focus();
            return false;
        }

        /*
        if (requireCustomsIdNumber) {
            if (/^[p|P]\d{12}$/.test(customsIdNumber)) {
                alert('개인통관고유부호가 유효하지 않습니다.');
                $('#requireCustomsIdNumber').focus();
                return false;
            }
        }
        */
        // agreement allcheck
        var isAllChecked = true;
        $('input:checkbox[name=agreeCheckbox]').each(function () {
            if (!$(this).is(':checked')) {
                isAllChecked = false;
                return false;
            }
        })
        if (!isAllChecked) {
            alert('비회원 개인정보 수집,이용에 동의하셔야 결제가 가능합니다.');
            return false;
        }

        // detail address
        if (receiverDetailAddress === '') {
            alert('상세주소를 입력해주세요.');
            $('#addressFromInputOrder').focus();
            return false;
        }

        var payTypeChk = false;
        $("input:radio[name='mode']").each(function(index, item){
            payTypeChk = $(this).is(":checked");
            if(payTypeChk) return false;
        })
        if (!payTypeChk) {
            alert('결제수단을 선택해 주세요');
            return false;
        }

        if(payType == 'ACCOUNT' && remitter == ''){
            alert('입금자명을 입력해주세요.');
            $('#remitter').focus();
            return false;
        }
        if(payType == 'ACCOUNT' && applyCashReceipt == true && cashReceiptKey == ''){
            if(cashReceiptIssuePurposeType == 'INCOME_TAX_DEDUCTION'){
                alert('휴대폰번호를 입력해주세요');
            }else{
                alert('사업자번호를 입력해주세요');
            }
            return false;
        }

        var orderData = {
            orderSheetNo: orderSheetNo,
            shippingAddress: {},
            useDefaultAddress: true,
            saveAddressBook: true,
            orderMemo: '',
            deliveryMemo: '',
            member: true,
            orderer: {
                ordererName: '',
                ordererContact1: '',
                ordererContact2: '',
                ordererEmail: ''
            },
            updateMember: true,
            tempPassword: null,
            coupons: null,
            subPayAmt: 0,
            orderTitle: titleProductName,
            payType: payType,
            pgType: pgType,
            remitter: null,
            applyCashReceipt: false,
            cashReceipt: {
                cashReceiptIssuePurposeType: 'INCOME_TAX_DEDUCTION',
                cashReceiptKey: null
            },
            bankAccountToDeposit: {
                bankAccount: '',
                bankCode: '',
                bankDepositorName: '',
            }
        }

        // orderer address
        orderData.orderer.ordererName = oname;

        var orderMobileNo = oContact;
        orderData.orderer.ordererContact1 = orderMobileNo;
        orderData.orderer.ordererEmail = oEmail;

        // delivery address
        orderData.shippingAddress.receiverName = receiverName;
        orderData.shippingAddress.receiverZipCd = receiverZipCd;
        orderData.shippingAddress.receiverAddress = addressInfo.receiverAddress;
        orderData.shippingAddress.receiverJibunAddress = addressInfo.receiverJibunAddress;
        orderData.shippingAddress.receiverDetailAddress = receiverDetailAddress;
        orderData.shippingAddress.receiverContact1 = receiverContact.replace(/_/gi, '');
        orderData.shippingAddress.deliveryMemo = $('#memo').val();
        if (requireCustomsIdNumber) {
            orderData.shippingAddress.customsIdNumber = customsIdNumber;
        }
        if(payType == 'ACCOUNT') {
            orderData.remitter = remitter;
            orderData.bankAccountToDeposit.bankAccount = tradeBankAccountInfo.bankAccount;
            orderData.bankAccountToDeposit.bankCode = tradeBankAccountInfo.bankCode;
            orderData.bankAccountToDeposit.bankDepositorName = tradeBankAccountInfo.bankDepositorName;
        }
        if(applyCashReceipt) {
            orderData.applyCashReceipt = applyCashReceipt;
            orderData.cashReceipt.cashReceiptIssuePurposeType = cashReceiptIssuePurposeType;
            orderData.cashReceipt.cashReceiptKey = cashReceiptKey;
        }

        // memo
        orderData.deliveryMemo = $('#memo').val();

        var confirmUrl = location.href.replace(/[^\/]*$/, '') + 'paymentresultempty.html';

        var cartNos = shop.getUrlParam('cartnos');
        if (cartNos !== null) {
            confirmUrl += '?cartNos=' + cartNos;
        }

        if (isGuest) {
            confirmUrl = location.href.replace(/[^\/]*$/, '') + 'paymentresultempty.html';
            orderData.member = false
            orderData.updateMember = false
            orderData.tempPassword = tempPasswordInput
        }

        // todo: coupon
        var couponRequest = {};
        var couponFlag = false;
        if (cartCouponIssueNo != '0') {
            couponRequest.cartCouponIssueNo = cartCouponIssueNo;
            couponFlag = true;
        }
        if (promotionCode != '') {
            couponRequest.promotionCode = promotionCode;
            couponFlag = true;
        }
        if (couponFlag) {
            const coupos = JSON.parse(JSON.stringify(couponRequest))
            orderData.coupons = coupos;
        }

        orderData.paymentAmtForVerification = paymentAmt;

        if($('#orderMemberJoin').is(':checked') && isGuest){
            tmpOrderData = orderData;
            tmpConfirmUrl = confirmUrl;
            this.memberJoin();
        }else{
            this.reservetion(orderData,confirmUrl);
        }

    },
    reservetion: function(orderData,confirmUrl){
        if(!$('#orderMemberJoin').is(':checked') && shop.isLogin()){
            shop.order.memberAddressModify(orderData);
        }
        NCPPay.setConfiguration({
            clientId: deployInfo.clientId,
            accessToken: shop.getAccessToken(),
            confirmUrl: confirmUrl,
            platform: shop.getPlatform()
        })

        const _this = this

        NCPPay.reservation(orderData, function (response) {
            deletePrevOrderInfoInStoreage(orderSheetNo)
        }, function (e) {
            console.log(e);
            if (e.code === 'PPE0002') {
                window.location.reload()
            }
            const codeparrten = /C2[0-9][0-9][0-9]/
            if (codeparrten.test(e.code) || e.code === 'C1020') {
                var requestUrl = './beforeorder.html'
                requestUrl += params.length > 0 ? ('?' + params.join('&')) : ''
                const orderinfo = getPrevOrderInfoInStoreage(orderSheetNo)
                if (!orderinfo) {
                    return
                }
                window.localStorage.orderInfo = orderinfo
                window.location.replace(requestUrl)
            }
        })
    },
    memberAddressModify: function(orderData){
        shop.ajax({
            url: deployInfo.apiUrl + '/profile/address',
            type: 'PUT',
            data: {
                "jibunAddress": orderData.shippingAddress.receiverJibunAddress,
                "jibunAddressDetail": orderData.shippingAddress.receiverDetailAddress,
                "streetAddress": orderData.shippingAddress.receiverAddress,
                "streetAddressDetail": orderData.shippingAddress.receiverDetailAddress,
                "zipCd": orderData.shippingAddress.receiverZipCd
            },
            success: $.proxy(function (res) {
                console.log(res);
            }, this),
            error: $.proxy(function (res) {
                //var result = JSON.parse(res.responseText);
                //console.log(result);
            }, this)
        })
    },
    memberJoin: function(){
        shop.ajax({
            url: deployInfo.apiUrl + '/profile',
            type: 'POST',
            data: {
                "memberId": $.trim(tmpOrderData.orderer.ordererEmail),
                'email': $.trim(tmpOrderData.orderer.ordererEmail),
                'password': $.trim(tmpOrderData.tempPassword),
                'memberName':$.trim(tmpOrderData.orderer.ordererName),
                'mobileNo': tmpOrderData.orderer.ordererContact1,
                'address': addressInfo.receiverAddress,
                "detailAddress": $('#addressFromInputOrder').val(),
                'jibunAddress': addressInfo.receiverJibunAddress,
                'jibunDetailAddress': $('#addressFromInputOrder').val(),
                "zipCd": $('#postcodeFromPopOrder').val()
            },
            success: $.proxy(function (res) {
                memberJoinSuccess = true;
                this.logIn();
            }, this),
            error: $.proxy(function (res) {
                memberJoinSuccess = false;
                var result = JSON.parse(res.responseText);
                console.log(result);
                if (result.code == 'E0006') {
                    alert('허용되지 않는 특수문자 입니다.');
                    $('#tempPassword').focus();
                } else {
                    this.openErrorPopup();
                }
            }, this)
        })
    },
    logIn: function(){
        shop.ajax({
            url: deployInfo.apiUrl + '/oauth/token',
            type: 'POST',
            data: {
                "captcha": "captcha",
                "memberId": $.trim(tmpOrderData.orderer.ordererEmail),
                'password': $.trim(tmpOrderData.tempPassword),
            },
            success: $.proxy(function (res) {
                memberLoginSuccess = true;
                shop.setAccessToken(res.accessToken, res.expireIn);
                alert('회원가입이 완료되었습니다. 결제를 계속 진행해주세요.\n\n' +
                    '결제 취소 시 주문정보가 모두 삭제 되니 유의 바랍니다.\n' +
                    '가입정보는 유지되므로 회원 주문으로 다시 진행할 수 있습니다.')
                this.reservetion(tmpOrderData,tmpConfirmUrl);
            }, this),
            error: $.proxy(function (res) {
                console.log(res);
                memberLoginSuccess = false;
                this.openErrorPopup();
            }, this)
        })

    },
    getEmailExist: function() {
        var email = $('#ordererEmail').val();
        var selector = 'ordererEmail';
        var emailExistsSuccess = false;

        shop.ajax({
            url: deployInfo.apiUrl + '/profile/id/exist?memberId=' + email,
            type: 'GET',
            async: false,
            data: null,
            success: $.proxy(function(res){
                var result = res;
                var message;
                if(result.exist){
                    message = '이메일은 로그인 시 아이디로 사용 됩니다. 입력하신 이메일은 이미 사용 중입니다.';
                    emailExistsSuccess = false;
                }else{
                    message = '사용 가능한 이메일입니다.';
                    emailExistsSuccess = true;
                }

                $('.' + selector + '-error').remove();
                getErrorMessage(selector, message);
            }),
            error: $.proxy(function(res){
                var result = JSON.parse(res.responseText);
                var message = '';

                if (result.code == 'E0006') {
                    message = (email == '') ? '이메일을 입력해주세요.' : '이메일 형식을 확인 해주세요.';
                    $('.' + selector + '-error').remove();
                    getErrorMessage(selector, message);
                    emailExistsSuccess = false;
                }
            })
        })

        return emailExistsSuccess;

    },
    inputMask: function(){
        $('#ordererContact').mask('000-0000-0000');
        $('#newAddressContact').mask('000-0000-0000');
    },
    validInit: function () {
        $('.payment').find("[data-invalid=true]").each(function () {
           var type = $(this).attr('data-invalid-type');
           var option = $(this).attr('data-invalid-option');
           var selector = $(this).attr('id');
           var errorText = '';
           if(type == 'email'){
               $(this).on({
                   focusout:function () {
                       $('.' + selector + '-error').remove();
                       if (!/\S+/.test($(this).val())) {
                           getErrorMessage(selector, '이메일을 입력해주세요.');
                           return;
                       }
                       if (!/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/.test($(this).val())) {
                           getErrorMessage(selector, '이메일 형식을 확인 해주세요.');
                           return;
                       }
                       if($('#orderMemberJoin').is(':checked')){
                           shop.order.getEmailExist();
                       }
                   }
               });
           }else if(type == 'mobile'){
               $(this).on({
                   focusout:function () {
                       $('.' + selector + '-error').remove();
                       if (!/\S+/.test($(this).val())) {
                           if(!$('#same').is(':checked') || option != 'delivery'){
                               getErrorMessage(selector,'휴대전화번호를 입력해주세요.');
                           }
                       }
                   }
               });
           }else if(type == 'name'){
               $(this).on({
                   focusout:function () {
                       $('.' + selector + '-error').remove();
                       if (!/\S+/.test($(this).val())) {
                           if(!$('#same').is(':checked') || option != 'delivery'){
                               getErrorMessage(selector,'이름을 입력해주세요.');
                               return;
                           }
                       }

                       var pattern = /[^a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣\u119E\u11A2]/;

                       //$('.' + selector + '-error').remove();
                       if (pattern.test($(this).val()) && $('#orderMemberJoin').is(':checked')) {
                           if(!$('#same').is(':checked') || option != 'delivery') {
                               getErrorMessage(selector, '한글, 영문만 입력 가능합니다.');
                           }
                       }
                   }
               });
           }else if(type == 'pw'){
               $(this).on({
                   focusout:function () {
                       $('.' + selector + '-error').remove();
                       var password = $(this).val();
                       var alpha = password.search(/[a-zA-Z]/ig);
                       var number = password.search(/[0-9]/g);
                       var special = password.search(/[!@#$%^&+=-_.()]/);
                       var spc_1 = password.search(/[^a-zA-Z0-9!@#$%^&+=-_.()]/);

                       if (spc_1 > -1) {
                           getErrorMessage(selector, '특수문자는 !@#$%^&+=-_.()만 사용 가능합니다.');
                       }

                       $('.' + selector + 'Check-error').remove();
                       if ((alpha < 0 && number < 0) || (alpha < 0 && special < 0) || (number < 0 && special < 0) || password.length < 8) {
                           getErrorMessage(selector, '비밀번호는 영문, 숫자, 특수문자 중 2가지 조합으로 8~20자로 입력하셔야 합니다.');
                       }

                       $('.' + selector + 'Check-error').remove();
                       if ($('#tempPasswordCheck').val() && $('#tempPasswordCheck').val() != $(this).val()) {
                           getErrorMessage(selector + 'Check', '비밀번호와 비밀번호 확인 값이 일치하지 않습니다.');
                       }
                   }
               });
           }else if(type == 'pwchk'){
               $(this).on({
                   focusout:function () {
                       $('.' + selector + '-error').remove();
                       if ($('#tempPassword').val() != $(this).val()) {
                           getErrorMessage(selector, '비밀번호와 비밀번호 확인 값이 일치하지 않습니다.');
                       }
                   }
               });
           }else if(type == 'postcode'){
               $(this).on({
                   focusout:function () {
                       $('.' + selector + '-error').remove();
                       if (!/\S+/.test($(this).val())) {
                           if(!$('#same').is(':checked') || option != 'delivery'){
                               getErrorMessage(selector,'주소를 입력해주세요');
                           }
                       }
                   }
               });
           }else{
               $(this).on('focusout', function () {
                   if(selector == 'addressFromPopOrder' || selector == 'addressFromPop'){
                       errorText = '주소를 입력해주세요.';
                   }
                   if(selector == 'ordererName' || selector == 'newAddressName'){
                       errorText = '이름을 입력해주세요.';
                   }
                   $('.' + selector + '-error').remove();
                   if (!/\S+/.test($(this).val())) {
                       if(!$('#same').is(':checked') || option != 'delivery'){
                           getErrorMessage(selector,errorText);
                       }
                   }
               });
           }
        });
    }
}

function agreeTypesFlag(agreeTypes) {
    var agreeTyps = {
        'termsOfUse': false,
        'privacyUsageAgreement': true,
        'nonMemberPrivacyUsageAgreement': false,
        'sellerPrivacyUsageAgreement': false,
        'customsClearanceAgreement': false,
        'overseaPrivacyUsageAgreement': false
    };

    for (var i in agreeTypes) {
        if (agreeTypes[i] == 'TERMS_OF_USE') {
            agreeTyps.termsOfUse = true;
        } else if (agreeTypes[i] == 'PRIVACY_USAGE_AGREEMENT') {
            agreeTyps.privacyUsageAgreement = true;
        } else if (agreeTypes[i] == 'NONE_MEMBER_PRIVACY_USAGE_AGREEMENT') {
            agreeTyps.nonMemberPrivacyUsageAgreement = true;
        } else if (agreeTypes[i] == 'SELLER_PRIVACY_USAGE_AGREEMENT') {
            agreeTyps.sellerPrivacyUsageAgreement = true;
        } else if (agreeTypes[i] == 'CUSTOMS_CLEARANCE_AGREEMENT') {
            agreeTyps.customsClearanceAgreement = true;
        } else if (agreeTypes[i] == 'OVERSEA_PRIVACY_USAGE_AGREEMENT ') {
            agreeTyps.overseaPrivacyUsageAgreement = true;
        }
    }

    return agreeTyps;
}

function getSellerList(deliveryGroups) {
    var sellerList = [];

    for (var i = 0; i < deliveryGroups.length; i++) {
        sellerList.push(deliveryGroups[i].partnerName);
    }

    return sellerList;
}

function setAddress(e, flag) {
    var idx = $(e).attr("_index");
    var target = $('#searchPopTarget').val();
    if(target == 'order'){
        addressInfoOrder = addressInfoAll[idx];
        if (flag == 'address') {
            $('#addressFromPopOrder').val(addressInfoOrder.receiverAddress);
            $('#addressFromInputOrder').val(addressInfoOrder.receiverDetailAddress);
        } else {
            $('#addressFromPopOrder').val(addressInfoOrder.receiverJibunAddress);
            $('#addressFromInputOrder').val(addressInfoOrder.receiverDetailAddress);
        }
        $('#postcodeFromPopOrder').val($('#postcode' + idx).text());
    }else{
        addressInfo = addressInfoAll[idx];
        if (flag == 'address') {
            $('#addressFromPop').val(addressInfo.receiverAddress);
            $('#addressFromInput').val(addressInfo.receiverDetailAddress);
        } else {
            $('#addressFromPop').val(addressInfo.receiverJibunAddress);
            $('#addressFromInput').val(addressInfo.receiverDetailAddress);
        }
        $('#postcodeFromPop').val($('#postcode' + idx).text());
    }

    if ($('#same').is(':checked') && target == 'order') {
        if (flag == 'address') {
            $('#addressFromPop').val(addressInfoOrder.receiverAddress);
            $('#addressFromInput').val(addressInfoOrder.receiverDetailAddress);
        } else {
            $('#addressFromPop').val(addressInfoOrder.receiverJibunAddress);
            $('#addressFromInput').val(addressInfoOrder.receiverDetailAddress);
        }
        $('#postcodeFromPop').val($('#postcode' + idx).text());
        addressInfo = addressInfoOrder;

    }

    $('.postcodeFromPopOrder-error,.postcodeFromPop-error,.addressFromPopOrder-error,.addressFromPop-error').remove();
    $('#addressesPopup').hide();
    shop.order.calWithAddress();
    $('#searchResult').html('').hide();
    $('#kword').val('');
}

function getPrevOrderInfoInStoreage(ordersheetno) {
    const temp = window.localStorage.preOrderInfos ? JSON.parse(window.localStorage.preOrderInfos) : []
    const orders = temp.filter(function (item) {
        return item.ordersheetno === ordersheetno
    })
    if (orders.length > 0) {
        return orders[0].orderInfo
    }
}

function deletePrevOrderInfoInStoreage(ordersheetno) {
    const temp = window.localStorage.preOrderInfos ? JSON.parse(window.localStorage.preOrderInfos) : []
    window.localStorage.preOrderInfos = JSON.stringify(temp.filter(function (item) {
        return item.ordersheetno !== ordersheetno
    }))
}

function validateNumber(event) {
    const allowKeys = [46, 8, 9, 27, 13]
    if (allowKeys.includes(event.keyCode) ||
        // Allow: Ctrl + A/X/V/C
        (event.ctrlKey === true) ||
        // Allow: home, end, left, right, down, up
        (event.keyCode >= 35 && event.keyCode <= 40)) {
        // let it happen, don't do anything
        return
    }
    // Ensure that it is a number and stop the keypress
    if ((event.shiftKey || (event.keyCode < 48 || event.keyCode > 57)) && (event.keyCode < 96 || event.keyCode > 105)) {
        event.preventDefault();
    }

    if (event.type === 'blur') {
        event.target.value = validNotNumber(event.target.value);
    }
}

// function changeKoreanToEmptyString (value) {
//   let regx = /[ㄱ-ㅎㅏ-ㅣ가-힣]/g;
//   if (regx.test(value)) {
//     value = value.replace(regx, '');
//   }
//   return value;
// }

function validNotNumber(value) {
    const regx = /[^0-9]/g;
    if (regx.test(value)) {
        value = value.replace(regx, '');
    }
    return value;
}

function focusOutSameInfoSet(ori,copy){
    if ($('#same').is(':checked')) {
        $('#' + copy).val($('#' + ori).val())
    }
}

function getErrorMessage(selector, message) {
    if($('.' + selector + '-error').length > 0) return;
    //if(selector == 'postcodeFromPopOrder' || selector == 'addressFromPopOrder' || selector == 'postcodeFromPop' || selector == 'addressFromPop') return;
    if(!message) message ='필수입력'
    $('#' + selector).after('<span style="" class="txt ' + selector + '-error">' + message + '</span>');
}
Handlebars.registerHelper("formartAmt", function (a) {
    return shop.order.formatNumber(a);
});

Handlebars.registerHelper("optionFormat", function (optionUsed, optionType, optionName, optionValue, inputs, addPrice, orderCnt, options) {
    return optionFormat(optionUsed, optionType, optionName, optionValue, inputs, addPrice, orderCnt);
});

Handlebars.registerHelper("priceHtml", function (salePrice, immediateDiscountAmt, additionDiscountAmt) {
    var priceHtml = '';
    var discountAmt = immediateDiscountAmt + additionDiscountAmt;
    var price = salePrice - discountAmt;
    if (discountAmt === 0) {
        priceHtml += '<li><strong>' + shop.order.formatNumber(price) + '원</strong></li>';
    } else {
        priceHtml += '<li><s>' + shop.order.formatNumber(salePrice) + '원</s></li><li class="fontSp"><strong>' + shop.order.formatNumber(price) + '원</strong></li>';
    }

    return priceHtml;
});

Handlebars.registerHelper("formatDeliveryAmt", function (a) {
    var str = '';
    if (parseInt(a) > 0) {
        str = '₩ ' + a;
    } else {
        str = '-';
    }
    return str;
});

Handlebars.registerHelper("ifPayOnDelivery", function (deliveryPayType, deliveryAmt, options) {
    if (deliveryPayType === 'PAY_ON_DELIVERY' && deliveryAmt > 0) {
        return options.fn(this);
    } else {
        return options.inverse(this);
    }
});

Handlebars.registerHelper("indexRender", function (index) {
    if (index == globalCurrentPage) {
        return '<a href="javascript:void(0)" id="idx' + index + '" _no="' + index + '" class="now"><em>' + index + '</em></a>';
    } else {
        return '<a href="javascript:void(0)" id="idx' + index + '" _no="' + index + '">' + index + '</a>';
    }
});

var index = 0;
Handlebars.registerHelper("ifProductCnt", function (orderProducts, deliveryAmt, deliveryPayType) {
    var str = '';
    if (parseInt(deliveryAmt) > 0) {
        str = formatCurrency(deliveryAmt) + '원';
    } else {
        str = '무료';
    }

    var rowspan = 0;
    for (var m = 0; m < orderProducts.length; m++) {
        rowspan += orderProducts[m].orderProductOptions.length;
    }

    var tdTag1 = '<td class="line6">';
    var tdTagGt1 = '<td class="line6" rowspan="' + rowspan + '">';
    var ulLiTag = '<ul><li>';
    var textTag = '<strong>' + str + '</strong>';
    var endTag = '</li></ul></td>';

    if (deliveryPayType === 'PAY_ON_DELIVERY' && deliveryAmt > 0) {
        textTag += '(착불)';
    }

    textTag += '<div class="remoteDeliveryAmt pc-visible"></div>';
    textTag += '<div class="remoteDeliveryAmt m-visible"></div>';
    var html = '';

    if (index == 0) {
        html = tdTagGt1 + ulLiTag + textTag + endTag;
    }
    if (index + 1 >= rowspan) {
        index = 0;
    } else {
        index++;
    }

    return html;
});

Handlebars.registerHelper("ifBrandName", function (brandName) {
    if (brandName != null && brandName !== '') {
        return '[' + brandName + ']';
    } else {
        return '';
    }
});

Handlebars.registerHelper("ifCouponSelected", function (cartCouponIssueNo, couponIssueNo) {
    if (cartCouponIssueNo == couponIssueNo) {
        return 'selected';
    } else {
        return '';
    }
});

Handlebars.registerHelper("stringCut", function (str, length) {
    return stringCut(str,length);
});