task :test_with_coveralls => [:test, 'coveralls:push'] do
  require 'coveralls/rake/task'
  Coveralls::RakeTask.new
end