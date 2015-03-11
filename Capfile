# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

require 'capistrano/rbenv'
require 'capistrano/rails'
require 'capistrano/puma'
require 'whenever/capistrano'

set :rbenv_type, :user
set :rbenv_ruby, '2.2.1'
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }
