class ProductsController < ApplicationController
  before_action :set_product, only: %i[edit update destroy ]
  def index
    @category = Category.where(parent_id: nil)
    @products = Product.all
  end
  def show
    @product = Product.find(params[:id]) 
  end
end
