class AddProductIdToProductCategory < ActiveRecord::Migration[6.1]
  def change
    add_reference :product_categories, :product, null: false, foreign_key: true
    add_reference :product_categories, :category, null: false, foreign_key: true
    
  end
end
