class AddProductToUserWishList < ActiveRecord::Migration[6.1]
  def change
   add_reference :user_wish_lists, :product, null: false, foreign_key: true
    
  end
end

