require 'test_helper'

describe MoviesController do
  it 'should get submit' do
    get :submit
    assert_response :success
  end

  it 'should get show'
end
