class ApplicationMailer < ActionMailer::Base
  default from: 'admin@quemjafez.com.br' # Nosso e-mail. NÃO ALTERAR!
  layout 'mailer'
end
