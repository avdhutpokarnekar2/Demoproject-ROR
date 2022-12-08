class UserOrder < ApplicationRecord
	has_many :user_addresses
	has_one :user
end
