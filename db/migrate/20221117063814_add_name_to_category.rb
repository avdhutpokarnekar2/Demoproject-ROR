class AddNameToCategory < ActiveRecord::Migration[6.1]
  def change
     add_column :categories, :name, :string, :limit => 100
     add_column :categories, :parent_id, :integer
     add_column :categories, :created_by, :integer
     add_column :categories, :created_date, :Date
     add_column :categories, :modify_by, :integer
  end
end
