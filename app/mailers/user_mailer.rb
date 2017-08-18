class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.validation.subject
  #
  def confirmation(resume)
    @resume = resume
    @resume.email_confirmation_token = SecureRandom.urlsafe_base64 # This create a randon token. More info: http://ruby-doc.org/stdlib-1.9.2/libdoc/securerandom/rdoc/SecureRandom.html
    @resume.save! # Persist the email_confirmation_token on data base
    @user_name = @resume.user.first_name
    @greeting = "Olá," # greeting message displayed on e-mail
    @greeting += " #{@user_name}" unless @user_name.nil? # Call user by his name if this variable is not empty

    mail(to: resume.school_email, subject: "Confirme seu email acadêmico | Quem já fez?")
  end
end
