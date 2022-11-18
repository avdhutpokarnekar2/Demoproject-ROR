class CreateProductAttributes < ActiveRecord::Migration[6.1]
  def change
    create_table :product_attributes do |t|

      t.timestamps
    end
  end
end
