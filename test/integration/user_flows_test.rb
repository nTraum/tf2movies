require 'test_helper'

# To be handled correctly this spec must end with "Integration Test"
describe 'UserFlows Integration Test' do
  include SharedIntegrationSteps
  it 'must be able to login for the first time' do
    login
  end

  it 'must be able to logout' do
    login
    logout
  end
end
