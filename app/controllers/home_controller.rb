class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @banners = BannerManagement.all
    @category = Category.where(parent_id: nil)
    @products = Product.all
    @prod_images = ProductImage.all
    @cms = Cm.last
  end
end
