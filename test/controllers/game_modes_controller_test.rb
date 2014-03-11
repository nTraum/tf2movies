require 'test_helper'

describe GameModesController do

  describe 'as admin' do
    it 'must get new' do
      as_logged_in_admin do
        get :new
        response.status.must_equal 200
      end
    end
    it 'must get manage' do
      as_logged_in_admin do
        FactoryGirl.create(:game_mode)
        get :manage
        assigns(:game_modes).size.must_equal 1
        response.status.must_equal 200
      end
    end
    it 'must create a game mode' do
      as_logged_in_admin do
        GameMode.count.must_equal 0
        post :create, :game_mode => FactoryGirl.attributes_for(:game_mode)
        flash[:notice].wont_be_nil
        GameMode.count.must_equal 1
        response.status.must_equal 302
      end
    end
    it 'must get edit' do
      as_logged_in_admin do
        game_mode = FactoryGirl.create :game_mode
        get :edit, 'id' => game_mode.id
        assigns(:game_mode).must_equal game_mode
        response.status.must_equal 200
      end
    end
    it 'must update a game mode' do
      as_logged_in_admin do
        game_mode = FactoryGirl.create :game_mode
        post :update, :id => game_mode.id, :game_mode => FactoryGirl.attributes_for(:game_mode)
        flash[:notice].wont_be_nil
        response.status.must_equal 302
      end
    end

    it 'must destroy a game mode' do
      as_logged_in_admin do
        game_mode = FactoryGirl.create :game_mode
        GameMode.count.must_equal 1
        delete :destroy, :id => game_mode.id
        flash[:notice].wont_be_nil
        response.status.must_equal 302
        GameMode.count.must_equal 0
      end
    end
  end

  it 'must redirect all moderation pages as moderator' do
    as_logged_in_moderator do
      game_mode = FactoryGirl.create :game_mode
      get :new
      response.status.must_equal 302
      get :manage
      response.status.must_equal 302
      post :create, :game_mode => FactoryGirl.attributes_for(:game_mode)
      response.status.must_equal 302
      get :edit, :id => game_mode.id
      response.status.must_equal 302
      post :update, :id => game_mode.id
      response.status.must_equal 302
      delete :destroy, :id => game_mode.id
      response.status.must_equal 302
    end
  end
  it 'must redirect all moderation pages as user' do
    as_logged_in_user do
      game_mode = FactoryGirl.create :game_mode
      get :new
      response.status.must_equal 302
      get :manage
      response.status.must_equal 302
      post :create, :game_mode => FactoryGirl.attributes_for(:game_mode)
      response.status.must_equal 302
      get :edit, :id => game_mode.id
      response.status.must_equal 302
      post :update, :id => game_mode.id
      response.status.must_equal 302
      delete :destroy, :id => game_mode.id
      response.status.must_equal 302
    end
  end
  it 'must redirect all moderation pages as banned user' do
    as_logged_in_banned_user do
      game_mode = FactoryGirl.create :game_mode
      get :new
      response.status.must_equal 302
      get :manage
      response.status.must_equal 302
      post :create, :game_mode => FactoryGirl.attributes_for(:game_mode)
      response.status.must_equal 302
      get :edit, :id => game_mode.id
      response.status.must_equal 302
      post :update, :id => game_mode.id
      response.status.must_equal 302
      delete :destroy, :id => game_mode.id
      response.status.must_equal 302
    end
  end
end