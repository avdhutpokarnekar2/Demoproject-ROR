class OrdersController < ApplicationController
	def index
		@orders = current_user.user_orders.all
	end

	def create  
		amount = @@f_value
		product_price_lists = [] 	
		products = Product.where(id: @cart.map(&:id))
		# if @@trans == 1
		# 	payment_gateway = 'COD'
		# 	trans_id = 1
		# else
		# 	payment_gateway = 'Stripe'		
		# 	trans_id = @@trans
		# end	
		address = current_user.user_addresses.last
		order = UserOrder.create(user_id: current_user.id,user_address_id: address.id,  transaction_id: trans_id,Total_amount: amount, payment_gateway: payment_gateway )
		if order.save
			products.each do |product|
			  order.order_details.create(product_id: product.id, amount:product.price, quantity: product.quantity)
				total = (product.quantity)*(product.price)
		  	product_price_lists << total	
			end	
			 UserMailer.placemail(current_user,order).deliver
			 UserMailer.ordermail(current_user,order).deliver
		end
		total_price = product_price_lists.inject {|sum,price| sum + price}
		@value = total_price.to_i
	end

	def show #track order
		order = current_user.user_orders.all
	    id = params[:user_order_id].to_i
		if (order.ids).include?(id)
	 		@user_order = UserOrder.find_by(id: id)
	 		@user_order = @user_order.status
	    elsif id != 0 && (order.ids).include?(id) == false  
	      flash[:alert] = "incorrect order id"
	    end		
	end
end


	# def new
    # @user = current_user
    # entered_code = params[:code]
    # coopan = Coupon.find_by(code: entered_code)
    # coupons = Coupon.all
	# 	coupons.each do |c|
	# 		if @user.coupons.include?(coopan) && 
    #      flash.now[:notice] = "Coupon already applied !"
    #   elsif entered_code == c.code 
    #     coopan.no_of_uses += 1  
    #     @user.coupons << coopan     
    #     @f_value = @final_value - (@final_value*(coopan.percent_off)/100)
    #     flash.now[:notice] = 'Coupon applied successfully'  
    #   else
    #     @f_value = @final_value
    #   end
    # end
	# end