'use strict';

var page = 1;
var pageSize = 12;
var categoryNo = '';
var totalCnt = 0;

$(function () {
  shop.category.ready();
  $('.title').text(categories[categoryNo].title)
  var productList = new ProductList(page, pageSize, shop.getUrlParam('categoryNo'), {
    more: $('.btn-row')
  })
})

shop.category = {
  ready: function () {
    this.init();
  },
  init: function () {
    page = 1;
    totalCnt = 0;
    categoryNo = shop.getUrlParam('categoryNo');
    this.getProducts();
    this.getPopus();

    $('.btn-row').click(function () {
      shop.category.nextPage();
    });
  },
  getProducts: function () {
    if (page > 1 && Math.ceil(totalCnt / pageSize) < page) {
      return;
    }
    shop.ajax({
      url: deployInfo.apiUrl + '/products/search?order.by=SALE_YMD&order.direction=DESC&fromDB=true&hasTotalCount=true&pageNumber=' + page + '&pageSize=' + pageSize + this.getCategories(),
      type: 'GET',
      data: null,
      success: $.proxy(function (res) {
        var myTemplate = Handlebars.compile($("#product-template").html());
        totalCnt = res.totalCount;
        var items = res.items;

        for (var i = 0; i < items.length; i++) {
          items[i].priceHtml = productUtils.getPrice(items[i].salePrice, items[i].immediateDiscountAmt, items[i].additionDiscountAmt);
          items[i].imageUrl = items[i].imageUrls[0];
        }


        if (Math.ceil(totalCnt / pageSize) === page) {
          $(".btn-row").hide();
        }
        $('.productsList').append(myTemplate({ "items": items }));
      }, this)
    })
  },
  getPopus: function () {
    if (shop.getCookie('CATEGORYPOP') !== getToday() || !shop.getCookie('CATEGORYPOP')) {
      shop.ajax({
        url: deployInfo.apiUrl + '/display/popups',
        type: 'GET',
        data: null,
        success: $.proxy(function (res) {
          totalCnt = res.totalCount;
          var items = res;
          var popus = '';

          var nowDateTime = new Date().getTime()
          for (var i = 0; i < items.length; i++) {
            if (new Date(items[i].startYmdt.replace(/-/g, '/') + ' GMT+9').getTime() < nowDateTime &&
              new Date(items[i].endYmdt.replace(/-/g, '/') + ' GMT+9').getTime() > nowDateTime) {
              popus = items[i]
              break;
            }
          }
          if (popus) {
            $('#content').render({ "popus": popus });
            $('.category-popupArea').show();
          }
        }, this)
      })
    }
  },
  nextPage: function () {
    page = page + 1;
    this.getProducts();
  },
  getCategories: function () {
    var arr = categoryNo.split(',');
    var val = '';
    for (var i = 0; i < arr.length; i++) {
      val = val + '&categoryNos=' + arr[i];
    }
    return val;
  }
}
