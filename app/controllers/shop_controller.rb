class ShopController < ApplicationController
	skip_before_action :authenticate_user!
	before_action :set_product, only: %i[show edit update destroy]
	
	require 'stripe'

	def e404
	end
	
	def track
		@user_order = current_user.user_orders.find_by(id: params[:user_order_id])
		unless @user_order.present?
			 @error = "User order not found"
		end
	end


	def blog_single
	end
	
	def blog
	end
	def order
		@orders = UserOrder.all
	end
	
	def checkout
		product_price_lists = [] 	
		products = Product.where(id: @cart.map(&:id))
		order = UserOrder.create(user_id: current_user.id)
		if order.save
			products.each do |product|
				order.order_details.create(product_id: product.id)
				total = (product.quantity)*(product.price)
		  	product_price_lists << total
			end
		end
		total_price = product_price_lists.inject {|sum,price| sum + price}
		@value = total_price.to_i
		@address = UserAddress.last
	end


  def create
  	@useraddress = UserAddress.new(address_params)
    if @useraddress.save
      flash[:success] = "New adress successfully added!"
      redirect_to shop_checkout_url
    else
      flash.now[:error] = "adress creation failed"
       render:new
    end
  end
	
	def contact
			@cont = ContactU.last
	end
	
	def contact_us
			@contact=ContactU.new(contact_params)
		if @contact.save
			flash[:success] = "New adress successfully added!"
      redirect_to shop_contact_path
      else
      flash.now[:error] = "adress creation failed"
       render:new
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
		
    @user = current_user
    @used_coupon = params[:code]
    coopan = Coupon.find_by(code: @used_coupon)
    @coupons = Coupon.all
    no_of_uses = 0
    @coupons.each do |coup|
    	if @used_coupon == coup.code
        if @user.coupons.include?(coopan)
          puts "coupn used"
        else
        	puts "valid coupon applied"
        	use = coopan.no_of_uses += 1
          @user.coupons << coup
          @total_value = @value - Coupon.last.percent_off.to_i
        end
      else
        puts "invalid"
      end
      if use == 1
       coup.save
      else
        puts "error "
    	end           
  		end
	end
	
	def login
	end
	
	def product_details
    @category = Category.find(params[:id])
    @products = @category.products
  end
	
	def shopee
	end

	def account
	end

	def add_to_cart
    id = params[:id].to_i
    session[:cart] << id unless session[:cart].include?(id)
    redirect_to root_path
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to root_path
  end

  def success
    Stripe.api_key = 'sk_test_51MD3qeSA33xedoIC2YAMsbM8jTPXNscjdxlbwAbWbtaApaRe3F6ZFXF5MR2uRaOlkvKva3Am0ev7AYSZHbMP5u8v00kK6dGWkg'
		response = Stripe::Checkout::Session.retrieve(
    id: params[:session_id])

 		@pay_id=response[:payment_intent]
 		pay_amount=response[:amount_total]
 		amount=pay_amount/100
 		@total=pay_amount/100
 		@pay_response = PaymentResponse.create(transation_id: response[:payment_intent], amount: amount)
  	@user_order = UserOrder.last
  end

  private	
  def address_params
  	params.permit(:Address,:pin_code, :mobile_no, :Country, :State, :Alternate_mobile_no )
	end

	def contact_params
		params.permit(:name,:email,:contact_no,:message)
	end

end