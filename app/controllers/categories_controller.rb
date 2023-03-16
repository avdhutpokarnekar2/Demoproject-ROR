class CategoriesController < ApplicationController
  def index
    @category = Category.where(parent_id: nil)
  end

  def show
    @category = Category.where(parent_id: nil)
    @parent_category = Category.find(params[:id]) if params[:id].present?
    @products = @parent_category.products
  end
end
