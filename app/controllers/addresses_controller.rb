class AddressesController < ApplicationController
  
  def index
    @address = current_user.user_addresses.last
  end

  #It is create new address.
  def create
    @useraddress = current_user.user_addresses.create( address_params )
    if @useraddress.save
      redirect_to checkout_index_path, notice: "New Address change successfully"
    else
      redirect_to checkout_index_path, notice:"Address not saved"
    end
  end

private 
  def address_params
    params.permit( :Address, :pin_code, :mobile_no, :Country, :State, :Alternate_mobile_no )
  end
end