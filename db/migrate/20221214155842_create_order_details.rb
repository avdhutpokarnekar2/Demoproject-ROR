class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.column :quantity, :integer
      t.column :amount, :float
      t.timestamps
    end
  end
end
