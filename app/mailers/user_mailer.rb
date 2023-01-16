class UserMailer < ApplicationMailer
  default from: 'apokarnekar@gmail.com'

  def welcome_send(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def admin_mail(user)
    @user = User.find_by(superadmin_role: true)
    mail(to: @user.email, subject: 'new user registered')
  end

  def contact_mail(user)
    @user = User.find_by(superadmin_role: true)
    mail(to: @user.email,subject:'contact_form save successfully')
  end

  def contact_update_mail(contact)
    @contact_info = contact
    @user = contact.email
    mail(to: @user,subject:'contact_form updated')
  end
  
  def placemail(user,order)
    @order = order 
    @user = user
    mail(to: @user.email, subject: 'Order placed')
  end
  
  def ordermail(user,order)
    @order = order
    @user = User.find_by(superadmin_role: true) 
    mail(to: @user.email,subject:'send mail to admin of order placed')
  end

  def status_mail(status)
    @status = status
    mail(to: 'apokarnekar@gmail.com', subject: 'Order placed status')
  end

  def cronemail
    @consolidated = UserOrder.where(created_at: (Time.now.midnight - 1.day)..Time.now.midnight)
    count = []
    @consolidated.each do |cd|
      a = cd.id
      count << a
    end
    @asd = count
    @user = User.find_by(superadmin_role: true)
    mail(to: @user.email, subject: 'consolidated mail for orders')
  end

  def wishlistmail
    @wishlist = UserWishList.all
    @user = User.find_by(superadmin_role: true)
    mail(to: @user.email, subject: 'consolidated mail for orders')
  end
end