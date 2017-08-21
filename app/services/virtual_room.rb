# Class used to create url for the virtual room of Appear.in

class VirtualRoom
  def self.create_url(meeting)
    url_base = "https://appear.in/"
    if (meeting.start_time - 10.minutes) < Time.now && Time.now < (meeting.end_time + 5.minutes) #TO-DO: Refatorar usando métodos em meeting model
      if meeting.virtual_room.nil?
        meeting.virtual_room = url_base + SecureRandom.urlsafe_base64
        meeting.save!
      end
      return meeting.virtual_room
    else
      return "https://google.com"
    end
  end
end
