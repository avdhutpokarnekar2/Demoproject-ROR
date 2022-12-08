class AddCodeToCoupon < ActiveRecord::Migration[6.1]
  def change
     add_column :coupons, :code, :string, :limit => 45
     add_column :coupons, :percent_off, :decimal, :limit => 100
     add_column :coupons, :created_by, :integer
     add_column :coupons, :created_date, :Date
     add_column :coupons, :modify_by, :integer
     add_column :coupons, :modify_date, :Date
     add_column :coupons, :no_of_uses, :integer
     
  end
end
