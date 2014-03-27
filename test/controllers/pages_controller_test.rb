require "test_helper"

describe PagesController do
  it 'should get about and display staff' do
    FactoryGirl.create :admin
    FactoryGirl.create :moderator

    get :about
    response.status.must_equal 200
    assigns(:moderators).size.must_equal 1, 'wrong number of mods'
    assigns(:admins).size.must_equal 1, 'wrong number of admins'
  end

  it 'should get welcome' do
    get :welcome
    response.status.must_equal 200
  end

  it 'should get contact' do
    get :contact
    response.status.must_equal 200
  end

  it 'should get 404' do
    get :not_found
    response.status.must_equal 404
  end
  it 'should get 500' do
    get :internal_error
    response.status.must_equal 500
  end
end
