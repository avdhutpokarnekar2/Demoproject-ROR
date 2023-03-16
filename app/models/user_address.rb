class UserAddress < ApplicationRecord
  has_many :user_order
  belongs_to :user
end
