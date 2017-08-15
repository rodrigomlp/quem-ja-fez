class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :meetings_as_undergraduate, class_name: "Meeting", foreign_key: :undergraduate_id, dependent: :destroy
  has_many :meetings_as_highschooler, class_name: "Meeting", foreign_key: :highschooler_id, dependent: :destroy

  has_many :resumes, dependent: :destroy
  has_many :universities, through: :resumes
  has_many :courses, through: :resumes

  # validates :first_name, presence: true # We don't have a form for this yet
  # validates :last_name, presence: true # We don't have a form for this yet
end
