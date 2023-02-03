class ProductsController < ApplicationController

  def index                 #Display the all products
    @category = Category.where(parent_id: nil)
    @products = Product.all
  end

  def show                  #Show perticuler product details
    @product = Product.find(params[:id])             
  end

end