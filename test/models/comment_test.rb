require 'test_helper'

describe Comment do
  it 'must be valid' do
    FactoryGirl.build(:comment).valid?.must_equal true
  end
end
