require 'test_helper'

describe MoviesController do
  it 'must get submit' do
    get :submit
    response.status.must_equal 200
  end

  it 'must get show' do
    movie = FactoryGirl.create :movie
    get :show, :id => movie.id
    response.status.must_equal 200
    assigns(:movie).must_equal movie
  end

  it 'must get edit for moderators and admins' do
    movie = FactoryGirl.create :movie
    as_logged_in_admin do
      get :edit, :id => movie.id
      response.status.must_equal 200
      assigns(:movie).must_equal movie
    end
    as_logged_in_moderator do
      get :edit, :id => movie.id
      response.status.must_equal 200
      assigns(:movie).must_equal movie
    end
  end

  it 'must redirect edit for users, banned_users and visitors' do
    movie = FactoryGirl.create :movie
    as_logged_in_user do
      get :edit, :id => movie.id
      response.status.must_equal 302
      flash[:alert].wont_be_nil
    end
    as_logged_in_banned_user do
      get :edit, :id => movie.id
      response.status.must_equal 302
      flash[:alert].wont_be_nil
    end
    get :edit, :id => movie.id
    response.status.must_equal 302
    flash[:alert].wont_be_nil
  end

  it 'must update for moderators and admins' do
    movie = FactoryGirl.create :movie
    as_logged_in_admin do
      post :update, :id => movie.id, :movie => FactoryGirl.attributes_for(:movie)
      response.status.must_equal 302
      flash[:notice].wont_be_nil
    end
    as_logged_in_moderator do
      post :update, :id => movie.id, :movie => FactoryGirl.attributes_for(:movie)
      response.status.must_equal 302
      flash[:notice].wont_be_nil
    end
  end

  it 'must redirect udpates for users, banned_users and visitors' do
    movie = FactoryGirl.create :movie
    as_logged_in_user do
      post :update, :id => movie.id, :movie => FactoryGirl.attributes_for(:movie)
      response.status.must_equal 302
      flash[:alert].wont_be_nil
    end
    as_logged_in_banned_user do
      post :update, :id => movie.id, :movie => FactoryGirl.attributes_for(:movie)
      response.status.must_equal 302
      flash[:alert].wont_be_nil
    end
    post :update, :id => movie.id, :movie => FactoryGirl.attributes_for(:movie)
    response.status.must_equal 302
    flash[:alert].wont_be_nil
  end

  it 'must create movies for users' do
    url = 'https://www.youtube.com/watch?v=0fCpAuxrQ_I'
    as_logged_in_user do
      VCR.use_cassette('movie_controller_test_create', :match_requests_on => [:method, VCR.request_matchers.uri_without_param(:key)]) do
        post :create, :url => url
        response.status.must_equal 302
        flash[:notice].wont_be_nil
        Movie.count.must_equal 1
      end
    end
  end

  it 'must create movies for moderators' do
    url = 'https://www.youtube.com/watch?v=0fCpAuxrQ_I'
    as_logged_in_moderator do
      VCR.use_cassette('movie_controller_test_create', :match_requests_on => [:method, VCR.request_matchers.uri_without_param(:key)]) do
        post :create, :url => url
        response.status.must_equal 302
        flash[:notice].wont_be_nil
        Movie.count.must_equal 1
      end
    end
  end

  it 'must create movies for admins' do
    url = 'https://www.youtube.com/watch?v=0fCpAuxrQ_I'
    as_logged_in_admin do
      VCR.use_cassette('movie_controller_test_create', :match_requests_on => [:method, VCR.request_matchers.uri_without_param(:key)]) do
        post :create, :url => url
        response.status.must_equal 302
        flash[:notice].wont_be_nil
        Movie.count.must_equal 1
      end
    end
  end

  it 'must redirect create movies for visitors and banned users' do
    url = 'https://www.youtube.com/watch?v=0fCpAuxrQ_I'
    as_logged_in_banned_user do
      post :create, :url => url
      response.status.must_equal 302
      flash[:alert].wont_be_nil
    end
    post :create, :url => url
    response.status.must_equal 302
    flash[:alert].wont_be_nil
  end
end
