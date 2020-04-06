jQuery(function($){
  var $js_part = $('.js_part');
  $js_part.on('click', 'a', function(e){
    e.preventDefault();
    var $this = $(this);
    if ($this.parent().hasClass('on')) {
      return false;
    } else {
      $('html, body').animate({'scrollTop': $js_part.eq($this.data('idx')-1).offset().top}, 500)
    }
  });
});