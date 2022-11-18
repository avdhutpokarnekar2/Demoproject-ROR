class AddAttributeValueToProductAttributeValues < ActiveRecord::Migration[6.1]
  def change
     add_column :product_attribute_values, :attribute_value, :string, :limit =>45
     add_column :product_attribute_values, :created_by, :integer
     add_column :product_attribute_values, :created_date, :Date
     add_column :product_attribute_values, :modify_by, :integer
     add_column :product_attribute_values, :modify_date, :Date
  end
end
