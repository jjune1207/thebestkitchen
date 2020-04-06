"use strict";

shop.profile = {
    fetchMemberInfo : function (callback) {
        shop.ajax({
            url: deployInfo.apiUrl + '/profile',
            type: 'GET',
            data: null,
            success: $.proxy(function (res) {
                callback(res)
            }, this)
        });
    },
    activeMember: function (data, callback) {
      shop.ajax({
        url: deployInfo.apiUrl + '/profile/openid',
        type: 'POST',
        data: data,
        success: $.proxy(function (res) {
          callback(res)
        }, this)
      });
    }
}
