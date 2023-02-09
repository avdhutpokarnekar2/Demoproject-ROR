class HomeController < ApplicationController
  before_action :authenticate_user!,only: [:index]
  require "MailchimpMarketing"
  
  def home
    @banners = BannerManagement.all
    @category = Category.where(parent_id: nil)
    @products = Product.all
    @prod_images = ProductImage.all
    @cms = Cm.last
  end

  #for subscribe the user
  def mailchimp
    mailchimp = MailchimpMarketing::Client.new
    mailchimp.set_config({
      :api_key => "bb7c4fc91c190c3c0285b16bbfa69a9c",
      :server => "us21"
      })
    list_id = "2f712a62e2"
    response = mailchimp.lists.add_list_member list_id,
                { email_address: params[:email],
                  status: "subscribed"
                }
    redirect_to root_url, notice: "Subscribed"
    rescue MailchimpMarketing::ApiError => e
      redirect_to root_url, alert: "This email is already in mailchimp list."
  end
  
end

