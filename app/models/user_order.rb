class UserOrder < ApplicationRecord
	# has_many :user_addresses
	belongs_to :user
	has_many :order_details, :dependent => :destroy 
	has_many :products, :through => :order_detail, :dependent => :destroy
  	attr_accessor :credit_card_number, :credit_card_exp_month, :credit_card_exp_year, :credit_card_cvv
	has_one :Payment
	enum payment_method: %i[credit_card]
	
	def create_payment
	    params = {
	      order_id: id,
	      credit_card_number: credit_card_number,
	      credit_card_exp_month: credit_card_exp_month,
	      credit_card_exp_year: credit_card_exp_year,
	      credit_card_cvv: credit_card_cvv
	    }
	    Payment.create!(params)
	end
end
