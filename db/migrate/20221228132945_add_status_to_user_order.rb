class AddStatusToUserOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :user_orders, :status, :integer, default: 0
  end
end
