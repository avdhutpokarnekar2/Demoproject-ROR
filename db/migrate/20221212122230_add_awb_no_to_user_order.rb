class AddAwbNoToUserOrder < ActiveRecord::Migration[6.1]
  def change
     add_column :user_orders, :payment_gateway, :string
     add_column :user_orders, :transaction_id, :string
     add_column :user_orders, :Total_amount, :integer
     add_column :user_orders, :Shipping_method, :string, default: "Regular shipping"
  end
end
