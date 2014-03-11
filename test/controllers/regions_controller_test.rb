require 'test_helper'

describe RegionsController do

  describe 'as admin' do
    it 'must get new' do
      as_logged_in_admin do
        get :new
        response.status.must_equal 200
      end
    end
    it 'must get manage' do
      as_logged_in_admin do
        FactoryGirl.create(:region)
        get :manage
        assigns(:regions).size.must_equal 1
        response.status.must_equal 200
      end
    end
    it 'must create a region' do
      as_logged_in_admin do
        Region.count.must_equal 0
        post :create, :region => FactoryGirl.attributes_for(:region)
        flash[:notice].wont_be_nil
        Region.count.must_equal 1
        response.status.must_equal 302
      end
    end
    it 'must get edit' do
      as_logged_in_admin do
        region = FactoryGirl.create :region
        get :edit, 'id' => region.id
        assigns(:region).must_equal region
        response.status.must_equal 200
      end
    end
    it 'must update a region' do
      as_logged_in_admin do
        region = FactoryGirl.create :region
        post :update, :id => region.id, :region => FactoryGirl.attributes_for(:region)
        flash[:notice].wont_be_nil
        response.status.must_equal 302
      end
    end

    it 'must destroy a region' do
      as_logged_in_admin do
        region = FactoryGirl.create :region
        Region.count.must_equal 1
        delete :destroy, :id => region.id
        flash[:notice].wont_be_nil
        response.status.must_equal 302
        Region.count.must_equal 0
      end
    end
  end

  it 'must redirect all moderation pages as moderator' do
    as_logged_in_moderator do
      region = FactoryGirl.create :region
      get :new
      response.status.must_equal 302
      get :manage
      response.status.must_equal 302
      post :create, :region => FactoryGirl.attributes_for(:region)
      response.status.must_equal 302
      get :edit, :id => region.id
      response.status.must_equal 302
      post :update, :id => region.id
      response.status.must_equal 302
      delete :destroy, :id => region.id
      response.status.must_equal 302
    end
  end
  it 'must redirect all moderation pages as user' do
    as_logged_in_user do
      region = FactoryGirl.create :region
      get :new
      response.status.must_equal 302
      get :manage
      response.status.must_equal 302
      post :create, :region => FactoryGirl.attributes_for(:region)
      response.status.must_equal 302
      get :edit, :id => region.id
      response.status.must_equal 302
      post :update, :id => region.id
      response.status.must_equal 302
      delete :destroy, :id => region.id
      response.status.must_equal 302
    end
  end
  it 'must redirect all moderation pages as banned user' do
    as_logged_in_banned_user do
      region = FactoryGirl.create :region
      get :new
      response.status.must_equal 302
      get :manage
      response.status.must_equal 302
      post :create, :region => FactoryGirl.attributes_for(:region)
      response.status.must_equal 302
      get :edit, :id => region.id
      response.status.must_equal 302
      post :update, :id => region.id
      response.status.must_equal 302
      delete :destroy, :id => region.id
      response.status.must_equal 302
    end
  end
end