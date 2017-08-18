class Resume < ApplicationRecord
  STANCE = [-1, 0, 1]
  RELATIVE_COMPLETION = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]

  validates :school_email, presence: true
  validate :validate_email

  # after_create :send_confirmation_email

  belongs_to :university
  belongs_to :course
  belongs_to :user
  has_many :meetings

  private

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


