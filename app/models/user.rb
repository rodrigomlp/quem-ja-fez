class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook] # Facebook connection

  has_many :meetings_accepted, class_name: "Meeting", foreign_key: :undergraduate_id, dependent: :destroy
  has_many :meetings_proposed, class_name: "Meeting", foreign_key: :highschooler_id, dependent: :destroy

  has_many :meetings
  has_many :resumes, dependent: :destroy
  has_many :universities, through: :resumes
  has_many :courses, through: :resumes
  has_many :events, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  mount_uploader :photo, PhotoUploader

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user
  end

  # validation to be discussed with the group
  # def profile_completed?
  #   if  skype.present? && personal_description.present?
  #     true
  #   else
  #     false
  #   end
  # end

end

