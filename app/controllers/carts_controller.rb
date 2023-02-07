class CartsController < ApplicationController

  #showing all values in cart
  def index
    cart_total_value
  end

  #add product in cart
  def create
    id = params[:id].to_i if params[:id].present?
    session[:cart] << id unless session[:cart].include?(id)
    redirect_to request.referrer, notice: "item added successfully in cart"
  end

  #remove product from cart
  def destroy
    id = params[:id].to_i if params[:id].present?
    session[:cart].delete(id)
    redirect_to carts_path, notice: "item successfully removed from cart"
  end

  #cart Toatal,shipping_cost
  def cart_total_value
    product_price_lists = []
    products = Product.find(session[:cart])
    products.each do |product|
      total = (product.quantity) * (product.price)
      product_price_lists << total
    end
    total_price = product_price_lists.inject {|sum,price| sum + price}
    shipping_total = shipping_charge(total_price)
    order_total = total_price + shipping_total rescue 0
    session[:totals] = order_total
    @cart_total = { total_price: total_price.to_i, 
                    shipping_total: shipping_total.to_i,
                    order_total: order_total.to_i }
  end

  def shipping_charge(value)
    value < 500 ? 50 : 0 if @cart_products.present?
  end

  #increase the product quanitity in the cart
  def add_quantity
    @product = Product.find(params[:id]) 
    @product.update(quantity: @product.quantity += 1)
    cart_total_value
  end

  #decrease the product quanitity in the cart
  def dec_quantity
    @product = Product.find(params[:id])
    if @product.quantity <= 1
      destroy
    end
    @product.update(quantity: @product.quantity -= 1)
    cart_total_value
  end
end
