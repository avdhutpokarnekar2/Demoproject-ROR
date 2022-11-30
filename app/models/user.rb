class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
           :omniauthable,:omniauth_providers=>[:google_oauth2,:github]

    def self.from_omniauth(response)
      User.find_or_create_by(uid: response[:uid], provider: response[:provider]) do |u|
        u.email = response[:info][:email]
        u.password = Devise.friendly_token[0, 20]
      end
    end
end
