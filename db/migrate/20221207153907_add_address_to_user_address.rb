class AddAddressToUserAddress < ActiveRecord::Migration[6.1]
  def change
     add_column :user_addresses, :Address, :string, :limit =>200
     add_column :user_addresses, :pin_code, :integer
     add_column :user_addresses, :mobile_no, :integer
     add_column :user_addresses, :Country, :string
     add_column :user_addresses, :State, :string
     add_column :user_addresses, :Alternate_mobile_no, :integer
  end
end
