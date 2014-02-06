require 'test_helper'

describe Movie do
  subject { FactoryGirl.build :movie }

  it 'must be valid' do
    subject.valid?.must_equal true
  end
end
