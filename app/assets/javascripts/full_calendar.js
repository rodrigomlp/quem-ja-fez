
$(document).ready(function(){





  $('.calendar').each(function(){
    var calendar = $(this);
    calendar.fullCalendar({
      /* Disable resizing and drag and drop for the highschooler*/
       // eventStartEditable: false,
       eventDurationEditable: false,
      selectAllow: function(selectInfo) {
         var duration = moment.duration(selectInfo.end.diff(selectInfo.start));
         return duration.asMinutes() == 30;
      },
      header:{
        left: 'prev,next',
        center: 'title',
        right: 'agendaWeek'
      },
      defaultView: 'agendaWeek',
      selectable: true,
      selectHelper: true,
      editable: true,
      eventLimit: true,
      events: '/events.json',


      select: function(start, end, event) {

          event.backgroundColor = 'green';
          $.ajax({
            type: "POST",
            url: "/events",
            data: {
              event: {
                start: start.toDate(),
                end: end.toDate(),
                color: "green"
              }
            }
          })



         $('.calendar').fullCalendar( 'renderEvent', {

            start: start,
            end: end,
            allDay: false,
          }, true);

      },

      eventDrop: function(event) {
        $.ajax({
          type: "PATCH",
          url: "/events/" + event.id,
          data: {
            event: {
              start: event.start.toDate(),
              end: event.end.toDate()
            }
          }
        });
      },

      eventClick: function(event){

        /*Check if the current user is a undegraduate which allows him to delete available time slots */
        if (window.user_undergraduate){

           var answer = confirm('Você quer deletar esses horários?');
           if (answer) {
               $.ajax({
               type: 'DELETE',
               url: "/events/" + event.id
             });
             window.location.reload()
           }
        }


       /*Highschoolers that want to schedule a time*/
       else {
          var answer = confirm('Você quer marcar esses horários?');
          if (answer) {
            $.ajax({
              type: "PATCH",
              url: "/events/" + event.id,
              data: {
                event: {
                  color: "red"
                }
              }
            });
            window.location.reload();
         }
       }


       },

      eventResize: function(event) {
        $.ajax({
          type: "PATCH",
          url: "/events/" + event.id,
          data: {
            event: {
              start: event.start.toDate(),
              end: event.end.toDate()
            }
          }
        });
      }
    });

  });


});
