class CheckoutController < ApplicationController
  def index
    @checkout_total = session[:totals] if session[:totals].present?
    @address = current_user.user_addresses.last
  end
end
