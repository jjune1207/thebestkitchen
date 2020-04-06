jQuery(function($){
  var $selectStar = $('.select-star');
  var $selectResult = $selectStar.find('.select-result');
  var $selectList = $selectStar.find('.select-list');

  $selectResult.on('click', function(e){
    e.stopPropagation();
    $selectList.show();
  });

  $(document).on('click', function(){
    $selectList.hide();
    $selectResult.attr('class', 'select-result').addClass($selectResult.data('star'));

    $snsList.hide();
  });

  $selectList.find('li').each(function(){
    var $this = $(this);
    $this.mouseenter(function(){
      $selectResult.attr('class', 'select-result');
      $selectResult.addClass($this.attr('class'));
    });
    $this.on('click', function(){
      $selectResult.data('star', $this.attr('class'));
    });
  });

  $selectList.mouseleave(function(){
    $selectResult.attr('class', 'select-result').addClass($selectResult.data('star'));
  });

  var $snsList = $('.sns-list');
  $('.operation .sharing').on('click', function(e){
      e.stopPropagation();
      $snsList.show();
  });
  $('.sharing button').on('click', function(e){
    e.stopPropagation();
    $snsList.show();
  });
});
