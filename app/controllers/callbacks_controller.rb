class CallbacksController < ApplicationController 
  def google_oauth2  #use of omniauth
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if user.present?
      redirect_to user_path(@user)
    else
      redirect_to '/user/sign_in'
    end
  end

  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user
  end

  def failure
    redirect_to root_path
  end
end
