class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.validation.subject
  #

  def confirmation(resume)
    @resume = resume
    @user_name = @resume.user.first_name
    @greeting = "Olá," # greeting message displayed on e-mail
    @greeting += " #{@user_name}" unless @user_name.nil? # Call user by his name if this variable is not empty

    mail(to: resume.school_email, subject: "Confirme seu email acadêmico | Quem já fez?")
  end

  def remember_highschooler(meeting)
    @highschooler = User.find(meeting.highschooler_id)

    @greeting = "Olá," # greeting message displayed on e-mail
    @greeting += " #{@highschooler.first_name}" unless @highschooler.first_name.nil? # Call user by his name if this variable is not empty

    mail(to: @highschooler.email, subject: "Quem já fez? | Faltam 24hrs para sua conversa")
  end

  def remember_undergraduate(meeting)
    @undergrad = User.find(meeting.undergraduate_id)
    @greeting = "Olá," # greeting message displayed on e-mail
    @greeting += " #{@undergrad.first_name}" unless @undergrad.first_name.nil? # Call user by his name if this variable is not empty

    mail(to: @undergrad.email, subject: "Quem já fez? | Faltam 24hrs para sua conversa")
  end

  def notify_interest(resume, undergraduate, highschooler)
    @undergraduate_name = undergraduate.first_name
    @highschooler_name = highschooler.first_name
    @resume_id = resume.id
    @greeting = "Olá," # greeting message displayed on e-mail
    mail(to: undergraduate.email, subject: "Quem já fez? | #{@highschooler_name} quer falar com você")
  end

  def notify_availability(resume,undergraduate, highschooler)
    @undergraduate_name = undergraduate.first_name
    @highschooler_name = highschooler.first_name
    @resume_id = resume.id
    @greeting = "Olá," # greeting message displayed on e-mail
    mail(to: highschooler.email, subject: "Quem já fez? | #{@undergraduate_name} disponibilizou um horário para conversa")
  end

  def user_feedback(feedback, email, referrer, user)
    @feedback = feedback
    @user_email = email
    @referrer = referrer
    @user = user
    mail(to: "admin@quemjafez.com.br", subject: "Feedback do Usuário")
  end

end
