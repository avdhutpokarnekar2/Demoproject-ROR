class ProfileController < ApplicationController
  skip_before_action :verify_authenticity_token 
  require "MailchimpMarketing"
  
  def update
    user = User.find(params[:id])
    if user.update( user_params )
      redirect_to profile_index_path(@user), notice: "User successfully updated." 
    else
      redirect_to profile_index_path(@user.errors), alert: @user.errors.full_messages
    end
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

private

  def user_params
    params.permit( :first_name, :last_name, :mobile_no, :email, :id)
  end

end