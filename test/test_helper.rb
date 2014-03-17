ENV['RAILS_ENV'] = 'test'

require 'coveralls'
Coveralls.wear!('rails')

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/pride'
require 'minitest/rails/capybara'
require 'database_cleaner'
require 'webmock/minitest'
require 'vcr'

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
# end

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock
end

DatabaseCleaner.strategy = :transaction

class MiniTest::Spec
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end

def as_logged_in_user
  user = FactoryGirl.create(:user)
  session[:user_id] = user.id
  yield
  session.delete :user_id
end

def as_logged_in_banned_user
  banned = FactoryGirl.create(:banned)
  session[:user_id] = banned.id
  yield
  session.delete :user_id
end

def as_logged_in_moderator
  moderator = FactoryGirl.create(:moderator)
  session[:user_id] = moderator.id
  yield
  session.delete :user_id
end

def as_logged_in_admin
  admin = FactoryGirl.create(:admin)
  session[:user_id] = admin.id
  yield
  session.delete :user_id
end