class AddImageNameToProductImages < ActiveRecord::Migration[6.1]
  def change
    add_column :product_images, :images_name, :string, :limit =>100
    add_column :product_images, :status, :integer ,default:0
    add_column :product_images, :created_by, :integer
    add_column :product_images, :modify_by, :integer

  end
end
