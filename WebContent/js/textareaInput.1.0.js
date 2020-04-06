jQuery(function($){
  var $js_length = $('.js_length')
  $('.js_textarea').on('keydown keyup keypress change', function(){
    var len = $(this).val().length;
    $js_length.text(len+'자 / 1000자');
  });
});