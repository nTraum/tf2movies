require 'test_helper'

# To be handled correctly this spec must end with "Integration Test"
describe 'UserFlows Integration Test' do
  include SharedIntegrationSteps
  it 'must be able to login for the first time', :js => true do
    login
    find('.alert.alert-success')
  end

  it 'must be able to login multiple times', :js => true do
    login
    logout
    login
  end

  #it 'must be able to logout', :js => true do
  #  login
  #  logout
  #end
end
