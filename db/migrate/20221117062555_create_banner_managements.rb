class CreateBannerManagements < ActiveRecord::Migration[6.1]
  def change
    create_table :banner_managements do |t|

      t.timestamps
    end
  end
end
