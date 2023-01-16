class ShopController < ApplicationController
	before_action :authenticate_user!,except: [:index ,:status]
	before_action :set_product, only: %i[show edit update destroy]
	 skip_before_action :verify_authenticity_token
	require "MailchimpMarketing"  
  require "digest"
	require 'stripe'

  def status
    mailchimp = MailchimpMarketing::Client.new
    mailchimp.set_config({
      :api_key =>  "bb7c4fc91c190c3c0285b16bbfa69a9c",
      :server => "us21"
    })
    list_id = "2f712a62e2"

    email =  current_user.email
    subscriber_hash = Digest::MD5.hexdigest email.downcase

    begin
      response = mailchimp.lists.get_list_member list_id, subscriber_hash
      @@response =response[status]
    end
  end


	
	def track
		@user_order = current_user.user_orders.find_by(id: params[:user_order_id])
		if @user_order.present?
			@user_order=@user_order.status
			flash.now[:notice] = "Please check your status"
		end
		
	end


	def blog_single
	end
	
	def blog
	end
	def order
		@orders = current_user.user_orders.all
	end
	
	def checkout_product
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
	
	def contact
		@contact = ContactU.new
			@cont = current_user.contact_us.last
	end
	
	def contact_us
			@user = current_user
			@contact=@user.contact_us.new(contact_params)
		if @contact.save
      redirect_to shop_contact_path, notice: "Your Contact form saved successfully"
      else
       render :contact
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
		product_price_lists = [] 
		@cart.each do |product| 
			total = (product.quantity)*(product.price)
			product_price_lists << total 
		end
		total_price = product_price_lists.inject {|sum,price| sum + price}
		@value = total_price.to_i
		
		if @value < 500 && @value > 0
      @shipping_cost = 50
    else
    	@shipping_cost = 0
    end
    @final_value = @value + @shipping_cost
    @@shipp = @shipping_cost
    @user = current_user
    @entered_code = params[:code]
    coopan = Coupon.find_by(code: @entered_code)
    @coupons = Coupon.all
		@coupons.each do |c|
			if @user.coupons.include?(coopan) 
         flash.now[:notice] = "Coupon already applied !"
      elsif @entered_code == c.code 
        coopan.no_of_uses += 1  
        @user.coupons << coopan     
        @f_value = @final_value - (@final_value*(coopan.percent_off)/100)
        @mv = @f_value
        @@f_value = @f_value
         flash.now[:notice] = 'Coupon applied successfully'  
      else
        @f_value = @final_value
        @@f_value = @final_value
      end
    end
  end

	
	def login
	end
	
	def product_details
    @category = Category.find(params[:id])
    @products = @category.products
    	@category = Category.where(parent_id: nil)
  end
	
	def shopee
		@category = Category.where(parent_id: nil)
		@products = Product.all
	 	@prod_images = ProductImage.all
	end

	def account
	end

	def add_to_cart
    id = params[:id].to_i
    session[:cart] << id unless session[:cart].include?(id)
    redirect_to root_path, notice: "item  added successfully in cart"
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to shop_cart_path, notice: "item successfully removed from cart"
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
    Stripe::Price.create({
    unit_amount: @@f_value*100,
    currency: 'usd',
    product: product.id,})
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

	def contact_params
		params.require(:contact_u).permit(:name,:email,:contact_no,:message)
	end

end