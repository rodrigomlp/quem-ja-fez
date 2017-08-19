 // This allows our search bar to be searchable withing the options presented
 $(document).ready(function() {
    $(".select-course-w-search").select2({
      placeholder: "Selecione um curso",
      allowClear: false,
      theme: "bootstrap"
    });
  });

 $(document).ready(function() {
    $(".select-university-w-search").select2({
      placeholder: "Selecione uma universidade",
      allowClear: false,
      theme: "bootstrap"
    });
  });
