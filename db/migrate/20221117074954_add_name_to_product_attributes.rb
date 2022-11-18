class AddNameToProductAttributes < ActiveRecord::Migration[6.1]
  def change

    add_column :product_attributes, :name, :string, :limit =>45
    add_column :product_attributes, :created_by, :integer
    add_column :product_attributes, :created_date, :Date
    add_column :product_attributes, :modify_by, :integer
    add_column :product_attributes, :modify_date, :Date
    
  end
end
