class CartsController < ApplicationController
	def index
	
	end

	def create
		id = params[:id].to_i
	    session[:cart] << id unless session[:cart].include?(id)
	    redirect_to root_path, notice: "item  added successfully in cart"
	end

	def destroy
	    id = params[:id].to_i
	    session[:cart].delete(id)
	    redirect_to carts_path, notice: "item successfully removed from cart"
	end

end
