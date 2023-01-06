namespace :sample do
    # desc 'saying hi to cron'
    task :test => [ :environment ] do
      UserMailer.cronemail.deliver
    end
end
