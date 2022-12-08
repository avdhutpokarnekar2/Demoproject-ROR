class CreateUserOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :user_orders do |t|

      t.timestamps
    end
  end
end
