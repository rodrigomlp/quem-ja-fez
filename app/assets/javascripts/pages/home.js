// Fade in cards when scrolling through home
$(function(){
  $('.first-row').hide();

  $(window).scroll(function (event) {
    var scroll = $(window).scrollTop() + $(window).height();

    if (scroll > 875) {
      $('.first-row').fadeIn(1250);
    } else {
      $('.first-row').fadeOut(250);
    }


    if (scroll > 1400) {
      $('.second-row').fadeIn(1250);
    } else {
      $('.second-row').fadeOut(250);
    }
  });
});
