class WishlistController < ApplicationController
  def index
    @wishlists = current_user.user_wish_lists
  end

  def new
  end
  
  def create
    user_id =  current_user.id
    product = Product.find(params[:id])
    if product.user_wish_lists.present? && current_user.user_wish_lists.present?
      redirect_to request.referrer, notice: "Product already in wishlist."
    else
      wishlist = UserWishList.create( user_id: user_id, product_id: product.id ) 
      if wishlist.save
        redirect_to root_path, notice: "Product added successfully in wishlist."
      end
    end
  end

  def destroy
    user_id =  current_user.id
    product = Product.find(params[:id])
    user_wishlist = UserWishList.find_by( product_id: product.id )
    if user_wishlist.destroy
      redirect_to wishlist_index_path, notice: "Product successfully removed from wishlist."
    else
      redirect_to wishlist_index_path, notice: "Product failed to remove from wishilst."
    end
  end
  
end

