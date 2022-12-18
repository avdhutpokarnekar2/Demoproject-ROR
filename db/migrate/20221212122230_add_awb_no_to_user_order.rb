class AddAwbNoToUserOrder < ActiveRecord::Migration[6.1]
  def change
     add_column :user_orders, :awb_no, :string, :limit =>100
     add_column :user_orders, :transaction_id, :string, :limit =>100
  end
end
