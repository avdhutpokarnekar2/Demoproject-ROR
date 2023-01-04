class UserMailer < ApplicationMailer
  default from: 'apokarnekar@gmail.com'

  def welcome_send(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def admin_mail(user)
    @user = user
    mail(to: 'apokarnekar@gmail.com', subject: 'new user registered')
  end

  def contact_mail(user)
    @user = user
    mail(to: 'apokarnekar@gmail.com',subject:'contact_form save successfully')
  end

  def contact_update_mail(contact_info)
    @contact_info = contact_info
    @user = User.find_by(email: contact_info.email)
    mail(to: @user.email,subject:'contact_form updated')
  end
  def task(order)
    @order = order 
    mail(to: 'apokarnekar@gmail.com',subject:'crone will be created successfully')
  end

end