class Coupon < ApplicationRecord
  has_many :coupons_useds , dependent: :destroy
  has_many :users, through: :coupons_useds
end
