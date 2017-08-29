$(document).ready(function() {
  $('#show-interest').on('click', function(event) {
    $(this).toggleClass('btn-primary');
    UserMailer.mail()
  });
});
