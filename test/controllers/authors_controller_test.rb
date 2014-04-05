require 'test_helper'

describe AuthorsController do
  it 'should get show' do
    author = FactoryGirl.create :author
    get(:show, {'id' => author.friendly_id})
    assert_response :success
  end

  it 'should get index'
end