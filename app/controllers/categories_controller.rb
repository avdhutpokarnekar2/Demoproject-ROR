class CategoriesController < ApplicationController
 
  def index
    @category = Category.where(parent_id: nil)
  end
    
  def show
    @category = Category.find(params[:id]) if params[:id].present?
    @products = @category.products
    @category = Category.where(parent_id: nil)
  end

end

