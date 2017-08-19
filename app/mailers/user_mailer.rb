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
end
