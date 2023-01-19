class ProductsController < ApplicationController
  before_action :set_product, only: %i[edit update destroy ]
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id]) 
  end

  def add_quantity                         #increase the product quanitity in the cart
    @item = Product.find(params[:id])
    @item.quantity += 1
    @item.save
    product_price_lists = []
    @shipping_cost = 0
    @cart.each do |product| 
      total = (product.quantity)*(product.price)
      product_price_lists << total 
    end
    total_price = product_price_lists.inject {|sum,price| sum + price}
    @value = total_price.to_i
    @shipping_cost = 50 if @value < 500 && @value > 0
    @total_amount = @value + @shipping_cost

  end    

  def dec_quantity                          #decrease the product quanitity in the cart
    @item = Product.find(params[:id])
    @item.quantity -= 1
    @item.save   
  end
 
  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to shop_cart_path, notice: "item successfully removed from cart"
  end

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

  def create
    @user = current_user.id
  end
  
end
