/*
 * Copyright 2018 NHN Ent. All rights Reserved.
 * NHN Ent PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */
document.write('<script src="' + shop.getRoot() + 'config/' + getProfile() +  '.js"><\/script>');

function getProfile () {
    var sampleMallUrls = [
        'http://sandbox-www.readyshop.co.kr/samplemall/',
        'http://local-mall.readyshop.co.kr/',
        'http://localhost:8080'
    ]
    var url = document.URL;
    var domain = url.match(/http[s]?:\/\/(.*?)([:\/]|$)/);

    if(sampleMallUrls.filter(function(s){return url.indexOf(s) >= 0}).length === 0) {
        console.log('deploy');
        return "deploy"
    }

    return "alpha";
}
