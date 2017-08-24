$('.feedback-button').on('click', function(event){
  event.preventDefault();
  $(this).parents(".meeting-card").find(".review-card").slideToggle();
});



$(function() {
  $('[name="meeting[rating]"]').click(function() {
    var form = $(this.form);
    $.ajax({
      url: form.attr("action"),
      type: "PATCH",
      data: $(this).serialize(),
    });
  });
});
