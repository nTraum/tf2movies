require 'test_helper'

describe Tf2Class do
  subject { FactoryGirl.build(:tf2_class) }

  it 'must be valid' do
    subject.must_be_instance_of Tf2Class
    subject.valid?.must_equal true
  end
end
