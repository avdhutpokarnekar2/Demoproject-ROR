class UserMailer < ApplicationMailer
  default from: 'apokarnekar@gmail.com'

  def welcome_email
    @user = params[:user]
    # @url  = 'http://localhost:3000/users/sign_up'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end