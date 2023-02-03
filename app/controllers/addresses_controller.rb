class AddressesController < ApplicationController
	def create
	  	@useraddress = current_user.user_addresses.create(address_params)
	    if @useraddress.save
	      redirect_to shop_checkout_url, notice: "New adress change successfully"
	    else
	      render :checkout
	    end
  	end

  	private	
  	
  	def address_params
  		params.permit(:Address,:pin_code, :mobile_no, :Country, :State, :Alternate_mobile_no)
	end
end
