require 'test_helper'

describe Author do
  it 'must be searchable' do
    FactoryGirl.create :author
    Author.search('bob').size.must_equal 1
  end
end
