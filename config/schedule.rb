set :environment, "development"
env :PATH, ENV['PATH']


set :output, "log/cron.log"
every 59.minute  do
	rake 'sample:test'	
end

every 59.minute  do
	rake 'wishlist:test'	
end