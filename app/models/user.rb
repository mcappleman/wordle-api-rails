class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable,
        :rememberable, :validatable, :omniauthable,
        omniauth_providers: [ :google_oauth2, :facebook ]

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :wordles, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.first_name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def authenticate(password)
    if valid_password?(password)
      self
    else
      false
    end
  end
end
