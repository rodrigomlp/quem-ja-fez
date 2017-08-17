class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.validation.subject
  #
  def validation(resume)
    @resume = resume

    mail(to: @resume.school_email, subject: "Please validate your e-mail!")
  end
end
