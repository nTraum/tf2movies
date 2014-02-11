require 'test_helper'

describe Tf2ClassesController do

  describe 'as admin' do
    it 'must get new' do
      as_logged_in_admin do
        get :new
        response.status.must_equal 200
      end
    end
    it 'must get moderate' do
      as_logged_in_admin do
        FactoryGirl.create(:tf2_class)
        get :moderate
        assigns(:tf2_classes).size.must_equal 1
        response.status.must_equal 200
      end
    end
    it 'must create a tf2 class' do
      as_logged_in_admin do
        Tf2Class.count.must_equal 0
        post :create, :tf2_class => FactoryGirl.attributes_for(:tf2_class)
        flash[:notice].wont_be_nil
        Tf2Class.count.must_equal 1
        response.status.must_equal 302
      end
    end
    it 'must get edit' do
      as_logged_in_admin do
        tf2_class = FactoryGirl.create :tf2_class
        get :edit, 'id' => tf2_class.id
        assigns(:tf2_class).must_equal tf2_class
        response.status.must_equal 200
      end
    end
    it 'must update a tf2 class' do
      as_logged_in_admin do
        tf2_class = FactoryGirl.create :tf2_class
        post :update, :id => tf2_class.id, :tf2_class => FactoryGirl.attributes_for(:tf2_class)
        flash[:notice].wont_be_nil
        response.status.must_equal 302
      end
    end

    it 'must destroy a tf2 class' do
      as_logged_in_admin do
        tf2_class = FactoryGirl.create :tf2_class
        Tf2Class.count.must_equal 1
        delete :destroy, :id => tf2_class.id
        flash[:notice].wont_be_nil
        response.status.must_equal 302
        Tf2Class.count.must_equal 0
      end
    end
  end

  it 'must redirect all moderation pages as moderator' do
    as_logged_in_moderator do
      tf2_class = FactoryGirl.create :tf2_class
      get :new
      response.status.must_equal 302
      get :moderate
      response.status.must_equal 302
      post :create, :tf2_class => FactoryGirl.attributes_for(:tf2_class)
      response.status.must_equal 302
      get :edit, :id => tf2_class.id
      response.status.must_equal 302
      post :update, :id => tf2_class.id
      response.status.must_equal 302
      delete :destroy, :id => tf2_class.id
      response.status.must_equal 302
    end
  end
  it 'must redirect all moderation pages as user' do
    as_logged_in_user do
      tf2_class = FactoryGirl.create :tf2_class
      get :new
      response.status.must_equal 302
      get :moderate
      response.status.must_equal 302
      post :create, :tf2_class => FactoryGirl.attributes_for(:tf2_class)
      response.status.must_equal 302
      get :edit, :id => tf2_class.id
      response.status.must_equal 302
      post :update, :id => tf2_class.id
      response.status.must_equal 302
      delete :destroy, :id => tf2_class.id
      response.status.must_equal 302
    end
  end
  it 'must redirect all moderation pages as banned user' do
    as_logged_in_banned_user do
      tf2_class = FactoryGirl.create :tf2_class
      get :new
      response.status.must_equal 302
      get :moderate
      response.status.must_equal 302
      post :create, :tf2_class => FactoryGirl.attributes_for(:tf2_class)
      response.status.must_equal 302
      get :edit, :id => tf2_class.id
      response.status.must_equal 302
      post :update, :id => tf2_class.id
      response.status.must_equal 302
      delete :destroy, :id => tf2_class.id
      response.status.must_equal 302
    end
  end
end