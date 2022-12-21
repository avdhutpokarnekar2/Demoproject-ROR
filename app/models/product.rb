class Product < ApplicationRecord
	has_many :product_images, :dependent => :destroy 
	has_many :product_attribute_assocs 
	has_many :product_categories
	has_many :categories, :through => :product_categories, :dependent => :destroy
	has_many :user_wish_lists, :dependent => :destroy
	has_many :order_details, :dependent => :destroy 
	has_many :user_orders, :through => :order_details, :dependent => :destroy
	belongs_to :user_wish_lists

	
end
