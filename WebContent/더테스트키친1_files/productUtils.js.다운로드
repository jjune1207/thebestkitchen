var productUtils = {
    getPrice: function (salePrice, immediateDiscountAmt, additionDiscountAmt, contentsIfPausing, saleStatusType) {
        var priceHtml = '';
        var discountAmt = immediateDiscountAmt + additionDiscountAmt;
        var price = salePrice - discountAmt;

        if(contentsIfPausing && contentsIfPausing !== null && contentsIfPausing != '' && saleStatusType == 'STOP'){
            priceHtml += '<p class="exhibition_text"><strong>' + stringCut(contentsIfPausing, 30) + ' </strong></p>';
        } else if (discountAmt === 0) {
            priceHtml += '<p class="exhibition_price"><strong>' + this.formatNumber(price) + ' 원</strong></p>';
        } else {
            priceHtml += '<p class="exhibition_price_del"><del>' + this.formatNumber(salePrice) + ' 원</del></p>'
            priceHtml += '<p class="exhibition_price_discount"><strong>' + this.formatNumber(price) + ' 원</strong></p>'
        }

        return priceHtml;
    },
    formatNumber: function (num) {
        var str = String(num.toFixed(0));
        return str.replace(/(\d)(?=(\d{3})+$)/g, '$1,');
    },
    productMapper: function (product) {
        product.priceHtml = productUtils.getPrice(product.salePrice, product.immediateDiscountAmt, product.additionDiscountAmt, product.contentsIfPausing, product.saleStatusType);
        product.imageUrl = product.imageUrls[0];
        product.availabilityDate = productUtils.dateFormat(product.saleStartYmdt) + " ~ " + productUtils.dateFormat(product.saleEndYmdt)
        return product;
    },
    dateFormat: function(date) {
        return date && date.split(' ')[0].replace(/-/g, '.').substr(5) || ""
    },
    imgResize: function(selector) {
        $(selector).each(function(idx, value){
            $(value).imagesLoaded().done(function(){
                if (value.width > value.height) {
                    $(value).parent().parent().addClass('posi-w');
                    $(value).css('margin-left', '-' + (value.width / 2) + 'px')
                    $(window).resize(function(){
                        $(value).css('margin-left', '-' + (value.width / 2) + 'px')
                    })
                }
            })
        })

    }
}

Handlebars.registerHelper("ifStock", function (a, b, options) {
    if (a < b) {
        return options.fn(this);
    } else {
        return options.inverse(this);
    }
});
Handlebars.registerHelper("ifStockAlready", function (a, options) {
  if (a <= 0) {
    return options.fn(this);
  } else {
    return options.inverse(this);
  }
});
Handlebars.registerHelper("ifStockSoon", function (a, options) {
  if (a < 5 && a > 0) {
    return options.fn(this);
  } else {
    return options.inverse(this);
  }
});
Handlebars.registerHelper("ifDiscount", function (a, b, options) {
    if (a + b > 0) {
        return options.fn(this);
    } else {
        return options.inverse(this);
    }
});
Handlebars.registerHelper("ifSoldout", function (a, b, options) {
    if (a === 0) {
        return options.fn(this);
    } else {
        return options.inverse(this);
    }
});

Handlebars.registerHelper("ifPeriod", function (salePeriodType, productSalePeriodType, options) {
    if(salePeriodType == "REGULAR") {
        return options.inverse(this);
    } else if(salePeriodType == "PERIOD") {
        return options.fn(this);
    } else if(productSalePeriodType == "REGULAR") {
        return options.inverse(this);
    } else {
        return options.fn(this);
    }
});

Handlebars.registerHelper("ifReady", function (a, options) {
    if(a == "READY") {
        return options.fn(this);
    } else {
        return options.inverse(this);
    }
});

Handlebars.registerHelper("ifOnsale", function (a, options) {
    if(a == "ONSALE") {
        return options.fn(this);
    } else {
        return options.inverse(this);
    }
});

Handlebars.registerHelper("ifFinished", function (a, options) {
    if(a == "FINISHED") {
        return options.fn(this);
    } else {
        return options.inverse(this);
    }
});
