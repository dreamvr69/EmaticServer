require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/puma'
require 'capistrano/puma/workers'
require 'capistrano/puma/nginx'
require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/sidekiq'
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }