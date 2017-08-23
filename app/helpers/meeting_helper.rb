module MeetingHelper
  def meeting_status(meeting)
    {
      scheduled: "Agendado",
      setting_up: "Em preparação",
      on_going: "Em andamento",
      completed: "Finalizado"
    }[meeting.status]
  end

  def stars_for(meeting, disabled = false)
    content_tag(:div, class: "stars#{disabled ? " disabled" : ""}") do
      (1..5).each do |star|
        concat content_tag(:input, nil, type: "radio", name: "meeting[rating]", id: "rating#{star}", value: star, checked: @meeting.rating == star)
        concat content_tag(:label, nil, for: "rating#{star}")
      end
    end
  end
end
