class ShopController < ApplicationController
	skip_before_action :authenticate_user!
	before_action :set_product, only: %i[ show edit update destroy ]

	def e404

	end
	
	def blog_single
	
	end
	
	def blog
	
	end
	
	def checkout
		@useraddress = UserAddress.new
	
	end

  def create
		@useraddress = UserAddress.new(user_address_params) 
    if @useraddress.save
      flash[:success] = "New to-do item successfully added!"
      redirect_to shop_checkout_url
    else
      flash.now[:error] = "To-do item creation failed"
      render :new
    end
  end
	
	def contact_us
	
	end
	
	def index
	 	@banners = BannerManagement.all
	 	@category = Category.all
	 	@products = Product.all
	 	@prod_images = ProductImage.all
	 	@useraddress = UserAddress.all
	end

	def cart
		@product_price_lists = [] 
		@cart.each do |product| 
		tp = (product.quantity)*(product.price)
		@product_price_lists << tp 
	end
		@total_price = @product_price_lists.inject {|sum,price| sum + price}
		@value =	@total_price.to_i
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

	end
	
	def shopee
	
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

  private
  	def user_address_params
  		params.require(:user_address).permit(:Address,:pin_code, :mobile_no, :Country, :State, :Alternate_mobile_no )
		end
end

