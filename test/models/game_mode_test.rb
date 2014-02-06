require 'test_helper'

describe GameMode do
  subject { FactoryGirl.build :game_mode }

  it 'must be valid' do
    subject.must_be_instance_of GameMode
    subject.valid?.must_equal true
  end
end
