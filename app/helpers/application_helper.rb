module ApplicationHelper

  # Show user avatar photo
  def display_user_avatar(user, args = {})
    # If values are not defined
    args[:css_class] ||= ""
    args[:size] ||= 'sm'

    # pre-defined sizes
    if args[:size]   == 'lg'
      height = 160
      width  = 160
      fa_size = "fa-5x"
      default_class = "avatar avatar-lg " + args[:css_class]
    elsif args[:size] == 'md'
      height = 100
      width  = 100
      fa_size = "fa-4x"
      default_class = "avatar avatar-md " + args[:css_class]
    elsif args[:size] == 'sm'
      height = 60
      width  = 60
      fa_size = "fa-3x"
      default_class = "avatar avatar-sm " + args[:css_class]
    else
      height = 40
      width  = 40
      fa_size = "fa-2x"
      default_class = "avatar avatar-xs " + args[:css_class]
    end

    # check which type of image to use
    if user.photo.file != nil
      cl_image_tag user.photo.url(:avatar), class: default_class
    elsif user.facebook_picture_url != nil
      image_tag user.facebook_picture_url + "&width=" + width.to_s + "&height=" + height.to_s, class:  default_class
    else
      content_tag(:i, "", class: "fa fa-user-circle-o #{fa_size}") # Place-holder image
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
      @result = "#{resultados} na busca pelo curso #{Course.find(params['course']).name}"
    elsif (params["course"] == "") && (params["university"] != "")
      @result = "#{resultados} na busca pela #{University.find_by_name(params[:university])}"
    else
      @result = "#{resultados} na busca pelo curso #{Course.find(params['course']).name} na #{University.find_by_name(params[:university])}"
    end
    return @result
  end

  def age_calculator(user)
    @age = ((Date.today - user.birth_date).to_i / 365) unless user.birth_date.nil?
  end

  def stars_generator(avg_rating)

  end
end


