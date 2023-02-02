class CartsController < ApplicationController
	def index
	
	end

	def create
		id = params[:id].to_i
	    session[:cart] << id unless session[:cart].include?(id)
	    redirect_to request.referrer, notice: "item  added successfully in cart"
	end

	def destroy
	    id = params[:id].to_i
	    session[:cart].delete(id)
	    redirect_to carts_path, notice: "item successfully removed from cart"
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
 


end
