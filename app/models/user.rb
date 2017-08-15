class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :meetings
  has_many :resumes, dependent: :destroy
  has_many :universities, through: :resumes
  has_many :courses, through: :resumes

  validates :first_name, presence: true
  validates :last_name, presence: true
end
