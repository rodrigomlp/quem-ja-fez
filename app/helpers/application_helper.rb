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

  def result_search(params)
    if (params["course"] == "") && (params["university"] == "")
      @result = "resultados"
    elsif (params["course"] != "") && (params["university"] == "")
      @result = "resultados na busca pelo curso #{params['course']}"
    elsif (params["course"] == "") && (params["university"] != "")
      @result = "resultados na busca pela universidade #{params['university']}"
    else
      @result = "resultados na busca pelo curso #{params['course']} na #{params['university']}"
    end

    return @result
  end
end
