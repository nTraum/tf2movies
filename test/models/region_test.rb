require "test_helper"

describe Region do
  subject { FactoryGirl.build :region }

  it 'must be valid' do
    subject.must_be_instance_of Region
    subject.valid?.must_equal true
  end
end
