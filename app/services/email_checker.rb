require 'mail'
# CUSTOM CLASS to CHECK e-mail domains

class EmailChecker
  def self.is_valid?(email, university)
    mail_address = Mail::Address.new(email) # tranforms string into a Mail Address class
    domain = mail_address.domain # gets domain of e-mail, a.k.a everything after '@'

    if university.email == domain
      return true
    else
      return false
    end
  end
end
