class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :initialize_session
  before_action :load_cart

  # def current_ability
  #   @current_ability ||= Ability.new(current_user)
  # end
private

  def initialize_session
    session[:cart] ||= []
  end

  def load_cart
    @cart_products = Product.find(session[:cart]) rescue nil
  end
end