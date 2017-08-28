 // This allows our search bar to be searchable withing the options presented

 $(document).ready(function() {
    // $(".select-course-w-search").select2();
    $("#course").select2({
      placeholder: "Selecione um curso",
      allowClear: true,
      theme: "bootstrap",
      width: "40%",
    });
  });

 $(document).ready(function() {
    $("#university").select2({
      placeholder: "Selecione uma universidade",
      allowClear: true,
      theme: "bootstrap",
      width: "40%",
    });
  });
