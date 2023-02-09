class ProductsController < ApplicationController

  #Display the all products
  def index
    @category = Category.where(parent_id: nil)
    @products = Product.all
  end

  #Show perticuler product details
  def show
    @product = Product.find(params[:id]) if params[:id].present?
  end
  
end