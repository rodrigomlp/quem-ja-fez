module MeetingHelper
  def meeting_status(meeting)
    {
      scheduled: "Agendado",
      setting_up: "Em preparação",
      on_going: "Em andamento",
      completed: "Finalizado"
    }[meeting.status]
  end
end
