class CheckoutController < ApplicationController
  def index
    @value = session[:totals]   
    @address = current_user.user_addresses.last
  end
end
