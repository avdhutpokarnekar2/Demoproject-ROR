class Product < ApplicationRecord
  has_many :product_images, dependent: :destroy
  has_many :product_attribute_assocs, dependent: :destroy
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories, dependent: :destroy
  has_many :user_wish_lists, dependent: :destroy
  has_many :users, through: :user_wish_lists
  has_many :order_details, dependent: :destroy
end
