$(function() {
  $('[name="meeting[rating]"]').change(function() {
    var form = $(this.form);
    $.ajax({
      url: form.attr("action"),
      type: "PATCH",
      data: $(this).serialize(),
    });
  });
});
