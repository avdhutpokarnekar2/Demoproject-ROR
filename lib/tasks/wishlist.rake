namespace :wishlist do
  desc "TODO"
  task :test => [:environment] do
    UserMailer.wishlistmail.deliver
  end
end
