class Product < ApplicationRecord
	has_many :product_images
	has_many :product_attribute_assocs
	has_many :product_category
end
