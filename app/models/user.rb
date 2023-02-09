class User < ApplicationRecord
  validates :email, format: { with: /[a-z0-9]+@[a-z]+\.[a-z]{2,3}/,message: "Please enter valid email" }
  after_create :welcome_send
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2,:github]
  has_many :coupons_useds, dependent: :destroy
  has_many :user_addresses, dependent: :destroy
  has_many :contact_us, dependent: :destroy
  has_many :coupons, through: :coupons_useds, dependent: :destroy
  has_many :user_orders, dependent: :destroy
  has_many :user_wish_lists, dependent: :destroy
  has_many :products, through: :user_wish_lists

  def self.from_omniauth(response)
    User.find_or_create_by(uid: response[:uid], provider: response[:provider]) do |u|
    u.email = response[:info][:email]
    u.password = Devise.friendly_token[0, 20]
    end
  end

  def welcome_send
    UserMailer.welcome_send(self).deliver
    UserMailer.admin_mail(self).deliver
  end  

end
