class AddProductIdToProductAttributeAssoc < ActiveRecord::Migration[6.1]
  def change
    add_reference :product_attribute_assocs, :product, null: false, foreign_key: true
    add_reference :product_attribute_assocs, :product_attributes, null: false, foreign_key: true
    add_reference :product_attribute_assocs, :product_attributes_value, null: false, foreign_key: true
  end
end
