class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  def index
    @products = Product.all
  end

  def add_quantity   #increase the product quanitity in the cart
    @item = Product.find(params[:id])
    @item.quantity += 1
    @item.save

    respond_to do |format|
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end

  def dec_quantity  #decrease the product quanitity in the cart
    @item = Product.find(params[:id])
    @item.quantity -= 1
    @item.save   
  end

  def wishlist
    @wishlists = UserWishList.all   #wishlist model
  end
  
  def add_to_wishlist   #product add to wishlist
    id = Product.find(params[:id])
    @user_wish_list = UserWishList.find_or_create_by(product_id: id.id)
    if @user_wish_list.save
       redirect_to root_path
    end
  end

  def remove_from_wishlist   #product remove from wishlist
    id = Product.find(params[:id])
    @user_wish_list = UserWishList.find_or_create_by(product_id: id.id)
    if @user_wish_list.destroy
      redirect_to root_path
    end
  end
end