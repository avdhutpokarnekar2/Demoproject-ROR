class ProductsController < ApplicationController
  before_action :set_product, only: %i[edit update destroy ]
  def index
    @category = Category.where(parent_id: nil)
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
    @products = Product.find(session[:cart])
    @products.each do |product| 
      total = (product.quantity)*(product.price)
      product_price_lists << total 
    end
    total_price = product_price_lists.inject {|sum,price| sum + price}
    @value = total_price.to_i
    @shipping_cost = 50 if @value < 500 && @value > 0
    @total_amount = @value + @shipping_cost

  end    

  def dec_quantity                        #decrease the product quanitity in the cart
    @item = Product.find(params[:id])
    @item.quantity -= 1
    @item.save   
    product_price_lists = []
    @shipping_cost = 0
    @products = Product.find(session[:cart])
    @products.each do |product| 
      total = (product.quantity)*(product.price)
      product_price_lists << total 
    end
    total_price = product_price_lists.inject {|sum,price| sum + price}
    @value = total_price.to_i
    @shipping_cost = 50 if @value < 500 && @value > 0
    @total_amount = @value + @shipping_cost

  end
 
  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to shop_cart_path, notice: "item successfully removed from cart"
  end

  def create
    @user = current_user.id
  end
  
end
