jQuery(function ($) {

  var $categoryPop = $('.category-popupArea');
  if ($categoryPop.length && !shop.getCookie('CATEGORYPOP')) {
    $categoryPop.hide();
  } else {
    $categoryPop.hide();
  }

  $('body').on('click', '.btn-close', function (e) {
    e.preventDefault();
    $categoryPop.hide();
  });

  $('body').on('click', '.btn-notShow', function (e) {
    e.preventDefault();
    var currentDate = new Date();
    shop.setCookie('CATEGORYPOP', getToday(), (2 * 24 * 60 * 60 * 1000));
    $categoryPop.hide();
  });
});