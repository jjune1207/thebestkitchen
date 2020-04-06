var slideCount = 3;
var optionSlideNo = 0;
var detailSlideNo = 0;
jQuery(function ($) {
        $('.slider-2').slick({
        slidesToShow: slideCount,
        slidesToScroll: slideCount,
        swipe:false,
        //infinite: true,
        // centerMode: true,
        // centerPadding: '5px',k
        // asNavFor: '.slider-1',
        focusOnSelect: true,
    });
    $('.slider-1').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: false,
        swipe: !isPC(),
        fade: true,
        dots: false,
        infinite: true,
        speed: 1,
        adaptiveHeight: false

    }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
        detailSlideNo = nextSlide;
        sliderResize(nextSlide,'productDetailImg')
    });
    /*
    setTimeout(function(){
        sliderResize(0,'productDetailImg')
    }, 1000);
    */

    $('.option-slider').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: false,
        swipe: false,
        fade: true,
        dots: false,
        infinite: true,
        speed: 1,
        adaptiveHeight: false
    }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
        optionSlideNo = nextSlide;
        $('.option-slider img').hide();
        $('.option-slider img').eq(nextSlide).show();
        sliderResize(nextSlide, 'productOptionImg');
    });

    $(window).resize(function(){
        sliderResize(detailSlideNo, 'productDetailImg');
        sliderResize(optionSlideNo, 'productOptionImg');
        if ($('.slider-2 .slick-track img').length <= slideCount) {
            $('.slider-2').slick('reinit');
        }
    });

});


function onClickOptionSlideNext() {
    $('.option-slider').slick('slickNext');
};
function onClickOptionSlidePrev() {
    $('.option-slider').slick('slickPrev');
};

function onClickSlide(slick) {
    var currentSlide = $(slick).attr('data-slick-index')
    // var currentSlide = $('.slider-2').slick('slickCurrentSlide');
    // alert(currentSlide);
    $('.slider-1').slick('slickGoTo', currentSlide);
};

function isPC() {
    var userAgent = navigator.userAgent || navigator.vendor || window.opera;
    if (userAgent.match(/iPad/i) || userAgent.match(/iPhone/i) || userAgent.match(/iPod/i) || userAgent.match(/Android/i)) {
        return false;
    }
    return true;
}

function sliderResize(nextSlide,resizeTarget) {
    var sliderElment, sliderLayout = null;
    if (resizeTarget == 'productDetailImg') {
        sliderElment = '.slider-1';
        sliderLayout = '.img-switch';
    } else if(resizeTarget == 'productOptionImg') {
        sliderElment = '.option-slider';
        sliderLayout = '.area_contents';
    }
    var activeSlide = $(sliderElment +' .slick-slide[data-slick-index="' + nextSlide + '"]');
    var activeImg   = activeSlide.find('img');
    if (typeof activeImg.get(0) === "undefined") { return; }
    activeImg.width('auto').height('auto');
    var maxWidth        = $(sliderLayout).width();
    var maxHeight       = $(sliderLayout).height();
    var naturalWidth    = activeImg.get(0).naturalWidth;
    var naturalHeight   = activeImg.get(0).naturalHeight;
    if(typeof naturalWidth == "undefined" || naturalWidth == null || naturalWidth == "") return;
    if(typeof naturalHeight == "undefined" || naturalHeight == null || naturalHeight == "") return;
    if(typeof maxWidth == "undefined" || maxWidth == null || maxWidth == "") return;
    if(typeof maxHeight == "undefined" || maxHeight == null || maxHeight == "") return;
    $('.popup-more .area_contents').css('overflow-y','hidden');
    if (maxHeight > naturalHeight && maxWidth > naturalWidth) {
    } else {
        var viewImageWidth = naturalWidth;
        var viewImageHeight = naturalHeight;

        if (resizeTarget == 'productDetailImg') {
            if (maxHeight < viewImageHeight) {
                var radio = (maxHeight / viewImageHeight).toFixed(2);
                viewImageHeight = maxHeight;
                viewImageWidth = (viewImageWidth * radio);
            }
        }
        if (maxWidth < viewImageWidth) {
            var radio = (maxWidth / viewImageWidth).toFixed(2);
            viewImageWidth = maxWidth;
            viewImageHeight = (viewImageHeight * radio);
        }
        activeImg.width(viewImageWidth);
        activeImg.height(viewImageHeight);
    }
    viewImageWidth = activeImg.width();
    viewImageHeight = activeImg.height();
    if (resizeTarget == 'productOptionImg') {
        var mLeft = 0;
        var mTop = 0;
        if (viewImageWidth < maxWidth) {
            mLeft = (maxWidth - viewImageWidth) / 2;
        }
        if (viewImageHeight < maxHeight) {
            mTop = (maxHeight - viewImageHeight) / 2;
        } else {
            $('.popup-more .area_contents').css('overflow-y','auto');
        }
        activeSlide.find('img').css('margin-left', mLeft);
        activeSlide.find('img').css('margin-top', mTop);
    }
}
