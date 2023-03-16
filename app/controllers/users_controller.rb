class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  require 'MailchimpMarketing'

  def subscribe
    Mailchimp.execute(email: params[:email])
    redirect_to root_url, notice: 'Subscribed'
    rescue MailchimpMarketing::ApiError
      redirect_to root_url, alert: 'This email is already in mailchimp list.'
  end
end
