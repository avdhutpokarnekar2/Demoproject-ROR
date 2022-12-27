class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable,:omniauth_providers=>[:google_oauth2,:github]
  has_many :coupons_useds
  has_many :coupons, through: :coupons_useds
  # has_many :user_orders
  has_one :user_wish_list
  has_many :products, through: :user_wish_list
  before_validation :create_on_stripe, on: :create
  def self.from_omniauth(response)
    User.find_or_create_by(uid: response[:uid], provider: response[:provider]) do |u|
    u.email = response[:info][:email]
    u.password = Devise.friendly_token[0, 20]
    end
  end

  def create_on_stripe
    params = { email: email, name: name}
    response = Stripe::user.create(params)
    self.user_id = response.id
  end
end
