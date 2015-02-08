lock '3.3.5'

set :application, 'brainana_shop'
set :repo_url, 'git@github.com:tonytonyjan/brainana_shop.git'
set :deploy_to, '/home/rails/shop-demo'
set :linked_files, %w[config/database.yml config/application.yml]
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system]