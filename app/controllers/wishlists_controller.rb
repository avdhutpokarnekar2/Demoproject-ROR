class WishlistsController < ApplicationController
	def wishlist      #wishlist model
    @wishlists = current_user.user_wish_lists.all
  end
  
  def add_to_wishlist  
    user_id =  current_user.id
    product = Product.find(params[:id])
    if product.user_wish_lists.present? && current_user.user_wish_lists.present?
      redirect_to root_path, notice: "already in wishlist"
    else
    wishlist = UserWishList.create(user_id: user_id , product_id: product.id) 
    if wishlist.save
      redirect_to root_path,  notice: "item  added successfully in wishlist"
    end
  end
  end

 def remove_from_wishlist
  user_id =  current_user.id
  product_id = params[:id]
  product = Product.find(params[:id])
  @user_wishlist = UserWishList.find_by(product_id: product.id)
  if @user_wishlist.destroy
    redirect_to products_wishlist_path, notice: "item successfully removed from wishlist"
  else
    redirect_to root_path, notice: "failed to remove from wishilst"
  end
  end

end
