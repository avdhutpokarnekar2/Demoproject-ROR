class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  def index
    @products = Product.all
  end

  def add_quantity   #increase the product quanitity in the cart
    @item = Product.find(params[:id])
    @item.quantity += 1
    @item.save
    
  end

  def dec_quantity  #decrease the product quanitity in the cart
    @item = Product.find(params[:id])
    @item.quantity -= 1
    @item.save   
  end

  def wishlist
    @wishlists = current_user.user_wish_lists.all #wishlist model
  end
  
  def add_to_wishlist  
    user_id =  current_user.id
    product = Product.find(params[:id])
    if product.user_wish_lists.present?
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

  def create
    @user = current_user.id
  end
  
end









# def new
#    if user_signed_in?
#    @user = User.find(current_user.id)
#    if @user.user_wishlist.present?
#      product_id= @user.user_wishlist.product_id
#      if params[:id].to_i.in? current_user.user_wishlist.product_id
#        redirect_to root_path, notice: "already in wishlist"
#      else
#        @user_wishlist=@user.user_wishlist.update(product_id:product_id.append(params[:id]))
#        redirect_to root_path, notice: "item added to wishlist"
#      end
#      # end
# 
#
#  end
#  end
