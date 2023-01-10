class AddUserOrderIdToUserAddress < ActiveRecord::Migration[6.1]
  def change
    add_reference :user_orders, :user_address, null: true, foreign_key: true
    add_reference :user_orders, :user, null:true, foreign_key:true    
  end
end
