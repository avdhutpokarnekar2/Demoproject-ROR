class AddfirstNameToUser < ActiveRecord::Migration[6.1]
  def change
     add_column :users, :first_name, :string
     add_column :users, :last_name, :string
     add_column :users, :mobile_no, :string
  end
end
