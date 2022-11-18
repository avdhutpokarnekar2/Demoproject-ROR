class AddConfKeyToConfiguration < ActiveRecord::Migration[6.1]
  def change
     add_column :configurations, :conf_key, :string, :limit => 45
     add_column :configurations, :conf_value, :string, :limit => 100
     add_column :configurations, :created_by, :integer
     add_column :configurations, :created_date, :Date
     add_column :configurations, :modify_by, :integer
     add_column :configurations, :modify_date, :Date
     # add_column :configurations, :status, :string, :limit => 45
  end
end
