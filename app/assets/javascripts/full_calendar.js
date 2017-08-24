
$(document).ready(function(){





  $('.calendar').each(function(){
    var calendar = $(this);
    calendar.fullCalendar({
      /* Disable resizing and drag and drop for the highschooler*/

       eventStartEditable: false,
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
      buttonText: {
        week: "Semana",
     },
     timezone: 'local',
     allDayText: '',

     monthNames: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
     monthNamesShort: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'],
     dayNames: ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sabado'],
     dayNamesShort: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'],
     events: '/results/' +  resume_id + '/events.json',

      select: function(start, end, event) {
         if (window.user_undergraduate && is_same_user){
            $.ajax({
            type: "POST",
            url: "/results/" + resume_id + "/events/",
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

         }
      },



      eventDrop: function(event) {
             $.ajax({
                type: "PATCH",
                url: "/results/" + resume_id + "/events/ " + event.id,
                data: {
                event: {
                    start: event.start.toDate(),
                    end: event.end.toDate()
                }
              }
            });
      },

      eventClick: function(event){
        /*Check if the current user is a undegraduate and the right user which allows him to delete available time slots */
        if (window.user_undergraduate && is_same_user){
               $.ajax({
               type: 'DELETE',
               url: "/results/" + resume_id + "/events/ " + event.id,
               success: function() {
                            $('.calendar').fullCalendar( 'refetchEvents' );
                }
             });
        }


       /*Highschoolers want sto schedule a time*/
       else {
          /*if he has not clicked yet (event is green) change it to red*/
          if (event.color == "green"){
                  $.ajax({
                    type: "PATCH",
                    url: "/results/" + resume_id + "/events/ " + event.id + ".js",
                    data: {
                      event: {
                        color: "red"
                      }
                    },
                    success: function() {
                            $('.calendar').fullCalendar( 'refetchEvents' );

                            // $('.calendar').fullCalendar( 'refetchEvents' );
                            // $('.calendar').fullCalendar({
                            //     events: events
                            // });
                            // console.log(events);
                            // $('.calendar').fullCalendar('destroy');
                            // $('.calendar').fullCalendar();
                        }

                      // event.color does not update when clicked although updated on DB.
                      // Is the problem the fact I'm using Javascript? Why?                    }
                  });
                  // window.location.reload()

            }
          /*if he has not clicked yet (event is green) change it to red*/
          else if (event.color == "red"){
                  $.ajax({
                    type: "PATCH",
                    url: "/results/" + resume_id + "/events/ " + event.id,
                    data: {
                      event: {
                        color: "green"
                      }
                    },
                    success: function() {
                            $('.calendar').fullCalendar( 'refetchEvents' );
                  }
                });
           }
        }
      }

    });

  });


});
