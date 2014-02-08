require "test_helper"

describe GameModesController do

  describe 'as admin' do
    it 'must get new' do
      act_as_admin
      get :new
      response.status.must_equal 200
    end
    it 'must get moderate' do
      act_as_admin
      FactoryGirl.create(:game_mode)
      get :moderate
      assigns(:game_modes).size.must_equal 1
      response.status.must_equal 200
    end
    it 'must create a game mode' do
      act_as_admin
      GameMode.count.must_equal 0
      post :create, :game_mode => FactoryGirl.attributes_for(:game_mode)
      flash[:notice].wont_be_nil
      GameMode.count.must_equal 1
      response.status.must_equal 302
    end
    it 'must get edit' do
      act_as_admin
      game_mode = FactoryGirl.create :game_mode
      get :edit, 'id' => game_mode.id
      assigns(:game_mode).must_equal game_mode
      response.status.must_equal 200
    end
    it 'must update a game mode' do
      act_as_admin
      game_mode = FactoryGirl.create :game_mode
      post :update, :id => game_mode.id, :game_mode => FactoryGirl.attributes_for(:game_mode)
      flash[:notice].wont_be_nil
      response.status.must_equal 302
    end

    it 'must destroy a game mode' do
      act_as_admin
      game_mode = FactoryGirl.create :game_mode
      GameMode.count.must_equal 1
      delete :destroy, :id => game_mode.id
      flash[:notice].wont_be_nil
      response.status.must_equal 302
      GameMode.count.must_equal 0
    end
  end

  it 'must redirect all pathes as moderator' do
    act_as_moderator
    game_mode = FactoryGirl.create :game_mode
    get :new
    response.status.must_equal 302
    get :moderate
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
  it 'must redirect all pathes as user' do
    act_as_user
    game_mode = FactoryGirl.create :game_mode
    get :new
    response.status.must_equal 302
    get :moderate
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
  it 'must redirect all pathes as banned user' do
    act_as_banned
    game_mode = FactoryGirl.create :game_mode
    get :new
    response.status.must_equal 302
    get :moderate
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