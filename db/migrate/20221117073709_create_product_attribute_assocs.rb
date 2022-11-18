class CreateProductAttributeAssocs < ActiveRecord::Migration[6.1]
  def change
    create_table :product_attribute_assocs do |t|

      t.timestamps
    end
  end
end
