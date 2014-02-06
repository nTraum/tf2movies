require 'test_helper'

describe SessionsController do
  it 'should destroy session and redirect back' do
    user = FactoryGirl.create :user
    request.env['HTTP_REFERER'] = root_path
    post(:destroy, nil, {'user_id' => user.id})
    assert_redirected_to root_path
    session['user_id'].must_be_nil
    flash[:notice].wont_be_nil
  end
end
