class UserOrder < ApplicationRecord
	belongs_to :user
	has_many :user_addresses, :dependent =>:destroy
	has_many :order_details, :dependent => :destroy 
	has_many :products, :through => :order_details, :dependent => :destroy
  	attr_accessor :credit_card_number, :credit_card_exp_month, :credit_card_exp_year, :credit_card_cvv
	# has_many :payments
	enum payment_method: %i[credit_card]
	# enum :status [:ordered, :shipped, :delivered]
	enum status: {
    ordered: 0,
    shipped: 1,
    delivered: 2
}
	
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

	def task
		UserMailer.task(self).deliver
	end
end
