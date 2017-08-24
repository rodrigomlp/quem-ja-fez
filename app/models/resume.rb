class Resume < ApplicationRecord
  RELATIVE_COMPLETION = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]

  validates :school_email, presence: true
  validates :school_email, uniqueness: true
  validates :university, presence: true
  validates :course, presence: true
  # validate :validate_email

  before_create :set_confirmation_token
  after_create :send_confirmation_email
  before_update :set_confirmation_token, if: :school_email_changed?
  after_update :send_confirmation_email, if: :school_email_changed?

  belongs_to :university
  belongs_to :course
  belongs_to :user
  has_many :meetings

  private

  def set_confirmation_token
    self.email_confirmation_token = SecureRandom.urlsafe_base64 # This create a randon token. More info: http://ruby-doc.org/stdlib-1.9.2/libdoc/securerandom/rdoc/SecureRandom.html
  end

  def send_confirmation_email # send email to validade school email
    UserMailer.confirmation(self).deliver_now
  end

  # Custom error: Verifica se o e-mail bate com a universidade selecionada
  def validate_email
    if !EmailChecker.is_valid?(self.school_email, self.university)
      errors.add(:school_email, 'E-mail universitário inválido')
    end
  end

  # Método a ser jogado no ERB para criar o o array do RELATIVE_COMPLETION
  # def range_of_completion
  #   completion_grades = []
  #   steps = 5
  #   i = 0
  #   while i <= 100
  #     completion_grades << i
  #     i += steps
  #   end
  #   completion_grades
  # end
end


