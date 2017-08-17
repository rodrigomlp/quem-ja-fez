class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.validation.subject
  #
  def validation(resume)
    @resume = resume
    @user = @resume.user.first_name
    @greeting = "Olá," # greeting message displayed on e-mail
    @greeting += " #{@resume.user.first_name}" unless @resume.user.first_name.nil? # Call user by his name if this variable is not empty

    mail(to: @resume.school_email, subject: "Validação do email acadêmico | Quem já fez")
  end
end
