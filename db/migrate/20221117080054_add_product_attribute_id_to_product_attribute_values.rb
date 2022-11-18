class AddProductAttributeIdToProductAttributeValues < ActiveRecord::Migration[6.1]
  def change
    add_reference :product_attribute_values, :product_attributes, null: false, foreign_key: true
  end
end
# github access token
# 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