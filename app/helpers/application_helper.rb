module ApplicationHelper

  def user_photo_index(resume)
    if resume.user.facebook_picture_url != nil
      user_photo_url = resume.user.facebook_picture_url
    elsif resume.user.photo.file != nil
      user_photo_url = resume.user.photo
    else
      user_photo_url = "http://placehold.it/100x100"
    end

    user_photo_url
  end

  def user_photo_show(resume)
    if resume.user.facebook_picture_url != nil
      @user_photo_url = resume.user.facebook_picture_url
    elsif resume.user.photo.file != nil
      @user_photo_url = resume.user.photo
    else
      @user_photo_url = "http://placehold.it/200x200"
    end
  end

  def date_in_words(meeting)
    if meeting.start_time.today?
      "Hoje"
    elsif meeting.start_time.to_date == Date.tomorrow
      "Amanhã"
    elsif meeting.start_time.to_date == Date.yesterday
      "Ontem"
    else
      l meeting.start_time.to_date, format: :short
    end
  end

end


