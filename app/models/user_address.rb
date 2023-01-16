class UserAddress < ApplicationRecord
  	validates :Address, presence: true
  	validates :pin_code,:presence=> true,:length=> {:minimum=>6,:maximum =>6} 
  	validates :mobile_no,:presence => true,
            :numericality => true,
            :length => { :minimum => 10, :maximum => 12 }
  	validates :Alternate_mobile_no,:presence => true,
            :numericality => true,
            :length => { :minimum => 10, :maximum => 12 }
	
	has_many :user_order
	belongs_to :user
end
