require "test_helper"

# To be handled correctly this spec must end with "Integration Test"
describe "UserFlows Integration Test" do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  it 'must be able to login and return to previous site' do
    get root_path
  end
end
