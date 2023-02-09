class UserOrder < ApplicationRecord
	after_update :status_mail
	belongs_to :user
	belongs_to :user_address
	has_many :order_details, dependent: :destroy 
	has_many :products, through: :order_details
	enum status:{
    ordered: 0,
    shipped: 1,
    delivered: 2
		}
	
  def status_mail
		if status == "shipped" or status == "delivered"
			UserMailer.status_mail(status).deliver
		end
	end

end







