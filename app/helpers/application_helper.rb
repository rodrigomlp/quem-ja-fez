module ApplicationHelper

  def user_photo_index(resume)
    if resume.user.facebook_picture_url != nil
      user_photo_url = resume.user.facebook_picture_url
    elsif resume.user.photo.file != nil
      user_photo_url = resume.user.photo
    else
      user_photo_url = "http://placehold.it/150x150"
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

  def result_search(params, resumes)
    if resumes.size == 1
      resultados = "resultado"
    else
      resultados = "resultados"
    end


    if (params["course"] == "") && (params["university"] == "")
      @result = "#{resultados}"
    elsif (params["course"] != "") && (params["university"] == "")
      @result = "#{resultados} na busca pelo curso #{Course.find(params['course'])}"
    elsif (params["course"] == "") && (params["university"] != "")
      @result = "#{resultados} na busca pela #{University.find(params['university'])}"
    else
      @result = "#{resultados} na busca pelo curso #{Course.find(params['course'])} na #{University.find(params['university'])}"
    end
    return @result
  end

  def age_calculator(user)
    @age = ((Date.today - user.birth_date).to_i / 365) unless user.birth_date.nil?
  end

  def stars_generator(avg_rating)

  end
end


