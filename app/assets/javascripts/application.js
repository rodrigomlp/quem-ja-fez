//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require momentjs
//= require fullcalendar
//= require_tree .






$(document).ready(function(){
  $('.calendar').each(function(){
    var calendar = $(this);
    calendar.fullCalendar({
      header:{
        left: 'prev,next,today',
        center: 'title',
        right: 'agendaWeek'
      },
      selectable: true,
      selectHelper: true,
      editable: true,
      eventLimit: true,

     // events: '/events.json',

      select: function(start, end) {
        console.log("OLA")
        console.log(start)
        console.log(end)
      //   $.getScript('/events/new', function() {
      //     $('#event_date_range').val(moment(start).format("MM/DD/YYYY HH:mm") + ' - ' + moment(end).format("MM/DD/YYYY HH:mm"))
      //     date_range_picker();
      //     $('.start_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'));
      //     $('.end_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));
      }



    });
  });
});
