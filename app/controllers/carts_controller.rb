class CartsController < ApplicationController
  # showing all values in cart
  def index
    calculated_total_cart_value
  end

  # add product in cart
  def create
    id = params[:id].to_i if params[:id].present?
    session[:cart] << id unless session[:cart].include?(id)
    redirect_to request.referrer, notice: 'Product added successfully in cart.'
  end

  # remove product from cart
  def destroy
    id = params[:id].to_i if params[:id].present?
    session[:cart].delete(id)
    redirect_to carts_path, notice: 'Product successfully removed from cart.'
  end

  def cart_total_product_value
    product_price_lists = []
    products = Product.find(session[:cart])
    products.each do |product|
      total = product.quantity * product.price
      product_price_lists << total
    end
    total_price = product_price_lists.inject { |sum, price| sum + price }
  end

  # cart Toatal,shipping_cost
  def calculated_total_cart_value
    total_price = cart_total_product_value
    shipping_total = shipping_charge(total_price)
    order_total = total_price + shipping_total if total_price.present?
    coupon = params[:coupon_off].to_i
    percentage_off = order_total * coupon / 100 if coupon.present? && order_total.present?
    coupon.positive? ? order_total -= percentage_off : order_total
    session[:totals] = order_total
    @cart_total = { total_price: total_price.to_i,
                    shipping_total: shipping_total.to_i,
                    order_total: order_total }
  end

  # shipping charges
  def shipping_charge(value)
    value < 500 ? 50 : 0 if value.present?
  end

  # increase the product quanitity in the cart
  def add_quantity
    @product = Product.find(params[:id]) if params[:id].present?
    @product.update(quantity: @product.quantity += 1)
    calculated_total_cart_value
  end

  # decrease the product quanitity in the cart
  def dec_quantity
    @product = Product.find(params[:id]) if params[:id].present?
    destroy if @product.quantity <= 1
    @product.update(quantity: @product.quantity -= 1)
    calculated_total_cart_value
  end
end
