class ShopController < ApplicationController
	before_action :authenticate_user!,except: [:index ,:status]
	# before_action :set_product, only: %i[show edit update destroy]
	skip_before_action :verify_authenticity_token
  require "digest"
	require 'stripe'

  def track   
		# @order = UserOrder.find(params[:id]) 
		# order = current_user.user_orders.all
    # id = params[:user_order_id].to_i
		# if (order.ids).include?(id)
 		# 	@user_order = UserOrder.find_by(id: id)
 		# 	@user_order = @user_order.status
    # elsif id != 0 && (order.ids).include?(id) == false  
    #   flash[:alert] = "incorrect order id"
    # end		
	end
	
	def checkout_product   #checkout
		amount = @@f_value
		product_price_lists = [] 	
		products = Product.where(id: @cart.map(&:id))
		if @@trans == 1
			payment_gateway = 'COD'
			trans_id = 1
		else
			payment_gateway = 'Stripe'		
			trans_id = @@trans
		end	
		address = UserAddress.last
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
	
	def checkout   
		@ship =  @@shipp
		@value = @@f_value
		@user_address = UserAddress.new
		@address = current_user.user_addresses.last
	end

  def create
  	@useraddress = current_user.user_addresses.create(address_params)
    if @useraddress.save
      redirect_to shop_checkout_url, notice: "New adress change successfully"
    else
      render :checkout
    end
  end
	

	def index
	 	@banners = BannerManagement.all
	 	@category = Category.where(parent_id: nil)
	 	@products = Product.all
	 	@prod_images = ProductImage.all
	 	@useraddress = UserAddress.all
	 	@user = User.all
	 	@cont = ContactU.last
	 	@cms = Cm.last
	 		
	end

	def show
  end

	def cart
	
  end

	
	def login
	end
	



  def success
  	Stripe.api_key = 'sk_test_51MD3qeSA33xedoIC2YAMsbM8jTPXNscjdxlbwAbWbtaApaRe3F6ZFXF5MR2uRaOlkvKva3Am0ev7AYSZHbMP5u8v00kK6dGWkg'
		response = Stripe::Checkout::Session.retrieve(
    id: params[:session_id])
 		@pay_id=response[:payment_intent]
 		@@trans = @pay_id
 		pay_amount=response[:amount_total]
 		amount=pay_amount/100
 		@total=pay_amount/100
 		@pay_response = PaymentResponse.create(transation_id: response[:payment_intent], amount: amount)
  	@user_order = UserOrder.last
  	checkout_product
  	session[:cart] = nil
  end

  def stripe
    product=Stripe::Product.create({name: 'Order 1'})
 		@session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [
      price_data: {
      product: product.id,
      unit_amount: @@f_value*100,
      currency: 'usd'},
      quantity: 1,],
      
      mode: 'payment',
      success_url: 'http://localhost:3000/shop/success?true&session_id={CHECKOUT_SESSION_ID}',
      cancel_url: root_url,})    
  end

  def cod
    @@trans = 1
  	checkout_product
  	@f_value = @@f_value
    @user_order = UserOrder.last
    session[:cart] = nil
  end
  

  private	
  def address_params
  	params.permit(:Address,:pin_code, :mobile_no, :Country, :State, :Alternate_mobile_no)
	end



end
	# def shopee
	# 	@category = Category.where(parent_id: nil)
	# 	@products = Product.all
	#  	@prod_images = ProductImage.all
	# end