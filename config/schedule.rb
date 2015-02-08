set :output, '/home/rails/shop-demo/shared/log/cron_log.log'
every :day do
  rake 'db:fixtures:load'
end
