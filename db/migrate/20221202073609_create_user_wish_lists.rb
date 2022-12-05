class CreateUserWishLists < ActiveRecord::Migration[6.1]
  def change
    create_table :user_wish_lists do |t|

      t.timestamps
    end
  end
end
