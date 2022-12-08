class ProductsController < ApplicationController
  # before_action :set_product, only: %i[ show edit update destroy ]

  def index
    @products = Product.all
    
  end

  def add_quantity
    @item = Product.find(params[:id])
    @item.quantity += 1
    @item.save   
  end

  def dec_quantity
    @item = Product.find(params[:id])
    @item.quantity -= 1
    @item.save   
  end


  def wishlist
    @wishlists = UserWishList.all
  end
  
  def add_to_wishlist
    id = Product.find(params[:id])
    @user_wish_list = UserWishList.find_or_create_by(product_id: id.id)
    if @user_wish_list.save
       redirect_to root_path
    end
  end

  def remove_from_wishlist
    id = Product.find(params[:id])
    @user_wish_list = UserWishList.find_by(product_id: id.id)
    if @user_wish_list.destroy
      redirect_to root_path
    end
  end



end