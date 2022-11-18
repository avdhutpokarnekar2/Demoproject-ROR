class AddNameToProduct < ActiveRecord::Migration[6.1]
  def change
     add_column :products, :name, :string, :limit => 100
     add_column :products, :sku, :string,  :limit => 45
     add_column :products, :short_description, :string, :limit => 100
     add_column :products, :long_description, :string, :limit => 100
     add_column :products, :price, :decimal
     add_column :products, :special_price, :decimal
     add_column :products, :special_price_from, :Date
     add_column :products, :special_price_to, :Date
     add_column :products, :status, :integer, default:0
     add_column :products, :created_by, :integer
     add_column :products, :created_date, :Date
     add_column :products, :modify_by, :integer
     add_column :products, :modify_date, :Date
         
  end
end
