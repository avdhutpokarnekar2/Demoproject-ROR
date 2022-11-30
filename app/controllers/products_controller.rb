class ProductsController < ApplicationController
  # before_action :set_product, only: %i[ show edit update destroy ]

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

  def index
    @products = Product.all
  end
 end