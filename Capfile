# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

require 'capistrano/rbenv'
require 'capistrano/rails'
require 'capistrano/puma'
require 'whenever/capistrano'
require 'capistrano/newrelic'

set :rbenv_type, :user
set :rbenv_ruby, '2.1.1'

set :puma_threads, [0, 8]
set :puma_workers, 2
set :puma_init_active_record, true
set :puma_preload_app, true

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }
