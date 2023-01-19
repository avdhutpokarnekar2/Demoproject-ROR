class HomeController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: :index
  require "MailchimpMarketing"  
  require "digest"
  def index
  end
  def mailchimp              #for subscribe the user
    mailchimp = MailchimpMarketing::Client.new
    mailchimp.set_config({
      :api_key => "bb7c4fc91c190c3c0285b16bbfa69a9c",
      :server => "us21"
    })
    list_id = "2f712a62e2"
    response = mailchimp.lists.add_list_member list_id, {
      email_address: params[:email],
      status: "subscribed"
    }
     redirect_to root_url
  end

  def unsubscribe             #for unsubscribe the user
    mailchimp = MailchimpMarketing::Client.new
    mailchimp.set_config({
      :api_key => "bb7c4fc91c190c3c0285b16bbfa69a9c",
      :server => "us21"
    })
    list_id = "2f712a62e2"
    email =  email_address= params[:email]
    subscriber_hash = Digest::MD5.hexdigest email.downcase
    response = mailchimp.lists.update_list_member list_id, subscriber_hash, {
    status: "unsubscribed"
    }
  end
end  
