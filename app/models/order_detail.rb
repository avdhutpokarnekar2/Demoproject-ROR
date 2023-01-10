class OrderDetail < ApplicationRecord
	belongs_to :user_order, :dependent => :destroy 
	belongs_to :product, :dependent => :destroy
end
