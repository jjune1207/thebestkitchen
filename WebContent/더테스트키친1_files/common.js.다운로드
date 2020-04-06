/*
 * Copyright 2018 NHN Ent. All rights Reserved.
 * NHN Ent PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */

var shop = {};
var loginTipsFlg = true;

shop.ajax = function (opt) {
    var requestUrl = opt.url;
    if (location.protocol === "https") {
        requestUrl = requestUrl.replace('http', 'https');
    }

    // parameters 세팅
    var params = {};

    if ($.type(opt.data) === 'object') {
        for (var key in opt.data) {
            if (requestUrl.indexOf('{' + key + '}') > -1) {
                requestUrl = requestUrl.replace('{' + key + '}', opt.data[key]);
            } else {
                params[key] = opt.data[key];
            }
        }
    } else if (opt.data == null) {
        params = '';
    } else {
        params = opt.data;
    }

    // header
    opt.header = opt.header || {};

    opt.header.platform = shop.getPlatform();
    opt.header.accessToken = shop.getAccessToken();
    opt.header.guestToken = shop.getGuestToken();
    // opt.header.accessToken = 'accessToken';
    opt.header.clientId = deployInfo.clientId;
    opt.header.Version = opt.header.Version || '1.0';

    // contentType
    opt.contentType = opt.contentType || "application/json";

    // processData
    opt.processData = opt.processData || false;

    // cache
    opt.cache = opt.cache || false;

    // enctype
    opt.enctype = opt.enctype || false;

    var async = true;
    if(opt.async === false){
        async = false
    }

    $.ajax({
        url: requestUrl,
        type: opt.type,
        async: async,
        data: params && JSON.stringify(params) || '',
        enctype: opt.enctype,
        dataType: "json",
        headers: opt.header,
        cache: opt.cache,
        contentType: opt.contentType,
        processData: opt.processData,
        success: function (data, textStatus, request) {
            opt.success(data, textStatus, request);
            if (shop.isLogin()) {
                loginTipsFlg = true;
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            var ERR = "Server is not available. Please try again later.";
            switch (jqXHR.status) {
                case 404:
                    opt.error ? opt.error(jqXHR, textStatus, errorThrown) : function () {
                        var result = JSON.parse(jqXHR.responseText);
                        if (result.code === 'E0005') {
                            alert(result.message);
                            // window.location.href = '../index.html';
                        }
                    }();
                    break;
                case 400:
                    opt.error ? opt.error(jqXHR, textStatus, errorThrown) : function () {
                        var result = JSON.parse(jqXHR.responseText);
                        if (loginTipsFlg && result.code === 'M0013') {
                            loginTipsFlg = false;
                            if (window.confirm(result.message)) {
                                window.location.href = './loginA.html';
                            } else {
                                window.location.href = '../index.html';
                            }
                        }
                        else if (result.code === 'M0020') {
                            window.location.href = ('./dormant_member.html');
                        }
                        else {
                            alert(result.message);
                        }
                        console.log("code : ", result.code);
                        console.log("data : ", result.data);
                        console.log("message : ", result.message);
                    }();
                    break;
                case 401:
                    opt.error ? opt.error(jqXHR, textStatus, errorThrown) : function () {
                        shop.removeAccessToken();
                        var result = JSON.parse(jqXHR.responseText);
                        //shop.removeAccessToken();
                        var url = window.location.href;
                        if (url.indexOf('mypage') > 0) {
                            var nextUrl = url.substring(url.indexOf('mypage') - 1);
                            alert(401)
                        } else {
                            window.location.href = '../index.html';
                        }
                        console.log("code : ", result.code);
                        console.log("data : ", result.data);
                        console.log("message : ", result.message);
                    }();
                    break;
                case 405:
                    opt.error ? opt.error(jqXHR, textStatus, errorThrown) : function () {
                        var result = JSON.parse(jqXHR.responseText);
                        alert(result.message);
                        console.log('405 METHOD_NOT_ALLOWED');
                        console.log("code : ", result.code);
                        console.log("data : ", result.data);
                        console.log("message : ", result.message);
                    }();
                    break;
                case 500:
                    opt.error ? opt.error(jqXHR, textStatus, errorThrown) : function () {
                        var result = JSON.parse(jqXHR.responseText);
                        alert(result.message);
                        console.log('500 unavailable.');
                        console.log("code : ", result.code);
                        console.log("data : ", result.data);
                        console.log("message : ", result.message);
                    }();
                    break;
                default:
                    opt.error ? opt.error(jqXHR, textStatus, errorThrown) : function () {
                        if (jqXHR.status === 0 || jqXHR.readyState === 0) {
                            return;
                        }
                        alert(ERR);
                        console.log("jqXHR : ", jqXHR);
                        console.log("textStatus : ", textStatus);
                        console.log("errorThrown : ", errorThrown);
                    }();
                    break;
            }
        },
        beforeSend: function (jqXHR) {
            //       showProgressbar();
            if (opt.beforeSend) {
                opt.beforeSend(jqXHR);
            }
        },
        complete: function () {
            //       hideProgressbar();
            if (opt.complete) {
                opt.complete();
            }
        }
    });
};

shop.getAccessToken = function () {
    return this.getCookie(deployInfo.loginCookieName);
};

shop.getGuestToken = function () {
    return this.getCookie(deployInfo.guestCookieName);
};

shop.setAccessToken = function (accessToken, exseconds) {
    this.setCookie(deployInfo.loginCookieName, accessToken, exseconds);
};

shop.removeAccessToken = function () {
    this.removeCookie(deployInfo.loginCookieName);
}

shop.setCookie = function (cname, cvalue, exseconds) {
    var expires = "";
    if (exseconds) {
        var d = new Date();
        d.setTime(d.getTime() + (exseconds * 1000));
        expires = "expires=" + d.toUTCString() + ";";
    }
    document.cookie = "theshop" + cname + "=" + cvalue + "; path=/; " + expires;
};
shop.getCookie = function (cname) {
    var name = "theshop" + cname;
    return this.getCookieRaw(name);
};

shop.getCookieRaw = function (name) {
    name = name + "="
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

shop.isLogin = function () {
    var token = shop.getAccessToken();
    if (token && token !== "") {
        return true;
    } else {
        return false;
    }
}

shop.removeCookie = function (cname) {
    document.cookie = "theshop" + cname + "=; path=/; expires=-1";
};

shop.getUrlParam = function (name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) {
        return decodeURIComponent(r[2]);
    }
    return null;
};

shop.getUrlParams = function (url) {
    url = url.replace(/#.*$/, '');
    var queryArray = url.split(/[?&]/).slice(1);
    var i;
    args = {};
    for (i = 0; i < queryArray.length; i++) {
        var match = queryArray[i].match(/([^=]+)=([^=]+)/);
        if (match !== null) {
            args[match[1]] = decodeURIComponent(match[2]);
        }
    }
    return args;
};

shop.getRoot = function () {
    return location.protocol + "//" + location.host + location.pathname.replace(/[^\/]*$/, '').replace(/common\//, '');
}

shop.changePath = function () {
    $('.need_change_path').each(function (index, elem) {
        var e = $(elem);
        if (e.attr('src')) {
            e.attr('src', shop.getRoot() + e.attr('src'))
        }
        if (e.attr('href')) {
            e.attr('href', shop.getRoot() + e.attr('href'))
        }
    })
}

shop.getPlatform = function () {
    if (/(iPhone|iPad|iPod|iOS|Android)/i.test(navigator.userAgent)) {
        return "MOBILE_WEB";
    } else {
        return "PC";
    }
}

shop.isMobile = function() {
    return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
}

shop.getWithPlatform = function () {
    if ($( window ).width() < 1024 ) {
        return "MOBILE_WEB";
    } else {
        return "PC";
    }
}

Array.prototype.unique = function () {
    var res = [];
    var json = {};
    for (var i = 0; i < this.length; i++) {
        if (!json[this[i]]) {
            res.push(this[i]);
            json[this[i]] = 1;
        }
    }
    return res;
}

var getIEVersion = function() {
    if (getBrowser() == 'IE') {
        var word = '';
        var agent = navigator.userAgent.toLowerCase();
        // IE old version ( IE 10 or Lower )
        if ( navigator.appName == "Microsoft Internet Explorer" ) word = "msie ";
        // IE 11
        else if ( agent.search( "trident" ) > -1 ) word = "trident/.*rv:";
        // Microsoft Edge
        else if ( agent.search( "edge/" ) > -1 ) word = "edge/";
        // 그외, IE가 아니라면 ( If it's not IE or Edge )
        else    return -1;
        var reg = new RegExp( word + "([0-9]{1,})(\\.{0,}[0-9]{0,1})" );
        if (reg.exec( agent ) != null) {
            return parseFloat( RegExp.$1 + RegExp.$2);
        } else {
            return -1;
        }
    }
}

function getBrowser() {
    if (!!window.ActiveXObject || "ActiveXObject" in window) {
        return 'IE';
    }
    return '';
}

function updateStartSnsDrop(target) {
    if (target === undefined) {
        target = '.select-star';
    }

    var $selectStar = $(target);
    var $selectResult = $selectStar.find('.select-result');
    var $selectList = $selectStar.find('.select-list');

    $selectResult.on('click', function (e) {
        e.stopPropagation();
        $selectList.show();
    });

    $(document).on('click', function () {
        $selectList.hide();
        $selectResult.attr('class', 'select-result').addClass($selectResult.data('star'));

        $snsList.hide();
    });

    $selectList.find('li').each(function () {
        var $this = $(this);
        $this.mouseenter(function () {
            $selectResult.attr('class', 'select-result');
            $selectResult.addClass($this.attr('class'));
        });
        $this.on('click', function () {
            $selectResult.data('star', $this.attr('class'));
        });
    });

    $selectList.mouseleave(function () {
        $selectResult.attr('class', 'select-result').addClass($selectResult.data('star'));
    });

    var $snsList = $('.sns-list');
    $('.sharing button').on('click', function (e) {
        e.stopPropagation();
        $snsList.show();
    });
}

var forwordToLoginPage = function (nextUrl) {
    window.location.href = shop.getRoot() + 'common/loginA.html?nextUrl=' + encodeURIComponent(nextUrl);
}

var forwordToTop = function (nextUrl) {
    window.location.replace('./index.html')
}

var searchList = function () {
    var keyword = $.trim($("#keyword").val());
    if (keyword.length < 1) {
        alert('상품 키워드를 입력해주세요.');
        $("#keyword").focus();
        return false;
    }
    window.location.href = shop.getRoot() + 'common/search.html?keyword=' + keyword;
}

var resetSearchText = function () {
    $('#keyword').val('');
    $("#keyword").focus();
}

var stringCut = function (string,count) {
    if (string.indexOf('\n') > -1 && string.indexOf('\n') < count) {
        return string.substr(0, string.indexOf('\n'))+"...";
    }
    if(string.length >= count){
        return string.substr(0,count)+"...";
    }
    return string;
}

var formatNumber = function (num){

    var str = 0;
    if (num) {
        str = String(num.toFixed(0));
        str = str.replace(/(\d)(?=(\d{3})+$)/g, '$1,');
    }
    return str;
}
function popup(options) {
    if (!options.width) options.width = 500;
    if (!options.height) options.height = 415;
    var status = new Array();
    $.each(options, function (i, v) {
        if ($.inArray(i, ['url', 'target']) == '-1') {
            status.push(i + '=' + v);
        }
    });
    var status = status.join(',');
    var win = window.open(options.url, options.target, status);
    return win;
}

function randomStringState() {
    var ar  = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    var result = '';

    for(var i = 0; i < 6; i++) {
        result += ar.charAt(Math.floor(Math.random() * ar.length));
    };

    return result;
}

function getProduct(callBack) {
    if(typeof callBack == 'function'){
        if(!shop.getUrlParam('pno')){
            return false;
        }
        shop.ajax({
            url: deployInfo.apiUrl + '/products/' + shop.getUrlParam('pno'),
            type: 'GET',
            data: null,
            success: $.proxy(function (res) {
                var goodsInfo = {
                    productName : res.baseInfo.productName,
                    productAmt : res.price.salePrice,
                    productNo : res.baseInfo.productNo,
                    stockCnt : 1,
                    categoryCode : res.categories[0].categories[0].categoryNo,
                    soldOut : res.stock.stockCnt <= 0 ? 1 : 2,
                }
                callBack(goodsInfo);
            }, this)
        });
    }
}

function getOrderInfo(callBack) {
    if(typeof callBack == 'function'){
        if(!shop.getUrlParam('orderNo') || !shop.isLogin()){
            return false;
        }
        shop.ajax({
            url: deployInfo.apiUrl + '/profile/orders/' + shop.getUrlParam('orderNo'),
            type: 'GET',
            data: null,
            success: $.proxy(function (res) {
                var orderInfo = new Array();
                if (res.orderOptionsGroupByPartner && res.orderOptionsGroupByPartner.length > 0) {
                    res.orderOptionsGroupByPartner.forEach(function(p) {
                        if (p.orderOptionsGroupByDelivery && p.orderOptionsGroupByDelivery.length > 0) {
                            p.orderOptionsGroupByDelivery.forEach(function(d) {
                                if (d.orderOptions && d.orderOptions.length > 0) {
                                    d.orderOptions.forEach(function(o) {
                                        var orderItem = o;
                                        var tempOrderItem = new Object();
                                        tempOrderItem["orderNo"] = orderItem.orderNo;
                                        tempOrderItem["productNo"] = orderItem.productNo;
                                        tempOrderItem["productName"] = orderItem.productName;
                                        tempOrderItem["orderCnt"] = orderItem.orderCnt;
                                        tempOrderItem["productAmt"] = orderItem.price.buyAmt;
                                        tempOrderItem["orderPrice"] = res.lastOrderAmount.payAmt;
                                        orderInfo.push(tempOrderItem);

                                    })
                                }
                            })
                        }
                    })
                }

                callBack(orderInfo);
            }, this)
        });
    }
}

function getCartInfo(callBack) {
    var path = location.href.replace(shop.getRoot(),'');
    var flag = false;
    if(path == 'common/cart.html'){
        flag = true;
    } else if($('.basket-wrap').length > 0 && $('.basket-wrap').hasClass('active')){
        flag = true;
    }
    if(typeof callBack == 'function' && flag){
        console.log('cart_script');
        if(shop.isLogin()){
            shop.ajax({
                url: deployInfo.apiUrl + '/cart',
                type: 'GET',
                data: null,
                success: $.proxy(function (res) {

                    var products = [];
                    var deliveryGroups = res.deliveryGroups;
                    for (var i = 0; i < deliveryGroups.length; i++) {
                        var orderProducts = deliveryGroups[i].orderProducts;
                        for (var j = 0; j < orderProducts.length; j++) {
                            var orderProductOptions = orderProducts[j].orderProductOptions;
                            for (var k = 0; k < orderProductOptions.length; k++) {
                                var orderProductOption = orderProductOptions[k];
                                var aProduct = {};
                                aProduct.productNo = orderProductOption.productNo;
                                aProduct.productAmt = orderProductOption.price.salePrice;
                                aProduct.productName = orderProducts[j].productName;
                                aProduct.orderCnt = orderProductOption.orderCnt;
                                products.push(aProduct);

                            }
                        }
                    }

                    var invalidProducts = res.invalidProducts;
                    for (var i = 0; i < invalidProducts.length; i++) {
                        var orderProductsOptions = invalidProducts[i].orderProductOptions;
                        for (var k = 0; k < orderProductsOptions.length; k++) {
                            var orderProductOption = orderProductsOptions[k];
                            var aProduct = {};

                            aProduct.productNo = orderProductOption.productNo;
                            aProduct.productAmt = orderProductOption.price.salePrice;
                            aProduct.productName = invalidProducts[i].productName;
                            aProduct.orderCnt = orderProductOption.orderCnt;
                            products.push(aProduct);
                        }
                    }

                    callBack(products);

                }, this)
            })

        }else{
            var cartItemRequests = JSON.parse(window.localStorage.cartInfo || '[]');
            shop.ajax({
                url: deployInfo.apiUrl + '/guest/cart',
                type: 'POST',
                data: cartItemRequests,
                success: $.proxy(function (res) {
                    var products = [];
                    var deliveryGroups = res.deliveryGroups;

                    if (deliveryGroups.length > 0 && typeof deliveryGroups[0].orderProducts != "undefined") {
                        guestCartProducts = deliveryGroups[0].orderProducts;
                    }
                    for (var i = 0; i < deliveryGroups.length; i++) {
                        var orderProducts = deliveryGroups[i].orderProducts;
                        for (var j = 0; j < orderProducts.length; j++) {
                            var orderProductOptions = orderProducts[j].orderProductOptions;
                            for (var k = 0; k < orderProductOptions.length; k++) {
                                var orderProductOption = orderProductOptions[k];
                                var aProduct = {};

                                aProduct.productNo = orderProductOption.productNo;
                                aProduct.salePrice = orderProductOption.price.salePrice;
                                aProduct.orderCnt = orderProductOption.orderCnt;
                                aProduct.productName = orderProducts[j].productName;
                                products.push(aProduct);
                            }
                        }
                    }

                    var invalidProducts = res.invalidProducts;
                    for (var i = 0; i < invalidProducts.length; i++) {
                        var orderProductsOptions = invalidProducts[i].orderProductOptions;
                        for (var k = 0; k < orderProductsOptions.length; k++) {
                            var orderProductOption = orderProductsOptions[k];
                            var aProduct = {};

                            aProduct.productNo = orderProductOption.productNo;
                            aProduct.salePrice = orderProductOption.price.salePrice;
                            aProduct.orderCnt = orderProductOption.orderCnt;
                            aProduct.productName = invalidProducts[i].productName;

                            products.push(aProduct);
                        }
                    }

                    callBack(products);

                }, this)
            })

        }

    }
}

Handlebars.registerHelper({
    contentExchange: function (value) {
        if(typeof value === 'string') {
            return value.replace(/>/g, '&gt;').replace(/</g, '&lt;').replace(/&/g, '&amp;').replace(/\n/g, "<br>").replace(/ /g, "&nbsp;")
        }
    }
})
Handlebars.registerHelper("getInstallmentPeriod", function (a, b, options) {
    var str = '';
    if (a > 0) {
      if (b) {
        str = a + '개월 무이자'
      } else {
        str = a + '개월'
      }
    } else {
      str = '일시불'
    }
    return str;
  });
