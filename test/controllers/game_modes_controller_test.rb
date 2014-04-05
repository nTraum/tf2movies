require 'test_helper'

describe GameModesController do

  describe 'show' do
    it 'must get show' do
      game_mode = FactoryGirl.create :game_mode
      get :show, :id => game_mode.friendly_id
      assigns[:game_mode].wont_be_nil
      response.status.must_equal 200
    end
  end

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

    it 'must not create invalid game modes' do
      as_logged_in_admin do
        post :create, :game_mode => FactoryGirl.attributes_for(:game_mode, :name => '')
        flash[:alert].wont_be_nil
        response.status.must_equal 302
        GameMode.count.must_equal 0
      end
    end

    it 'must get edit' do
      as_logged_in_admin do
        game_mode = FactoryGirl.create :game_mode
        get :edit, 'id' => game_mode.friendly_id
        assigns(:game_mode).must_equal game_mode
        response.status.must_equal 200
      end
    end

    it 'must update a game mode' do
      as_logged_in_admin do
        game_mode = FactoryGirl.create :game_mode
        post :update, :id => game_mode.friendly_id, :game_mode => FactoryGirl.attributes_for(:game_mode)
        flash[:notice].wont_be_nil
        response.status.must_equal 302
      end
    end

    it 'must not update invalid game modes' do
      as_logged_in_admin do
        game_mode = FactoryGirl.create :game_mode
        post :update, :id => game_mode.friendly_id, :game_mode => FactoryGirl.attributes_for(:game_mode, :name => '')
        flash[:alert].wont_be_nil
        response.status.must_equal 302
      end
    end

    it 'must destroy a game mode' do
      as_logged_in_admin do
        game_mode = FactoryGirl.create :game_mode
        GameMode.count.must_equal 1
        delete :destroy, :id => game_mode.friendly_id
        flash[:notice].wont_be_nil
        response.status.must_equal 302
        GameMode.count.must_equal 0
      end
    end
  end
end