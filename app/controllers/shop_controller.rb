class ShopController < ApplicationController
	skip_before_action :authenticate_user!
	before_action :set_product, only: %i[ show edit update destroy ]

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





	def e404

	end
	
	def blog_single
	
	end
	
	def blog
	
	end
	
	
	
	def checkout
	
	end
	
	def contact_us
	
	end
	
	def index
	 	@banners = BannerManagement.all
	 	@category = Category.all
	 	@products = Product.all
	 	# @images = @product.ProductImage.image
	 	@prod_images = ProductImage.all

	end
	
	def login
	
	end
	
	def product_details

	
	end
	
	def shopee
	
	end
	
end
