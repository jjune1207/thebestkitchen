"use strict";

shop.coupon = {
    fetchProductCoupon : function (productNo, callback) {
        shop.ajax({
            url: deployInfo.apiUrl + '/coupons/products/' + productNo + '/issuable/coupons',
            type: 'GET',
            data: null,
            success: $.proxy(function (res) {
                callback(res)
            }, this)
        });
    },
    downLoadCoupon : function (couponNo, callback) {
        shop.ajax({
            url: deployInfo.apiUrl + '/coupons/' + couponNo + '/download',
            type: 'POST',
            data: null,
            success: $.proxy(function (res) {
                callback(res)
            }, this)
        });
    }
}