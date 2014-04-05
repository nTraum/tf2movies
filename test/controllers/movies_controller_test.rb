require 'test_helper'

describe MoviesController do

  describe 'love' do
    it 'must add a movie to a users love list' do
      as_logged_in_user do
        movie = FactoryGirl.create :movie
        post :love, :id => movie.friendly_id
        movie.users.size.must_equal 1
        response.status.must_equal 302
        flash[:notice].wont_be_nil
      end
    end

    it 'must remove a movie from a users love list when the association already exists' do
      as_logged_in_user do
        movie = FactoryGirl.create :movie
        post :love, :id => movie.friendly_id
        movie.users.size.must_equal 1
        post :love, :id => movie.friendly_id
        movie.users(true).size.must_equal 0
        response.status.must_equal 302
        flash[:notice].wont_be_nil
      end
    end
  end
  it 'must get submit' do
    get :submit
    response.status.must_equal 200
  end

  it 'must get show' do
    movie = FactoryGirl.create :movie
    get :show, :id => movie.friendly_id
    response.status.must_equal 200
    assigns(:movie).must_equal movie
  end

  it 'must get manage' do
    FactoryGirl.create(:movie, :status_cd => Movie.pending)
    as_logged_in_moderator do
      get :manage
      response.status.must_equal 200
      assigns[:pending_movies].wont_be_nil
    end
  end

  it 'must get edit' do
    movie = FactoryGirl.create :movie
    as_logged_in_moderator do
      get :edit, :id => movie.friendly_id
      response.status.must_equal 200
      assigns(:movie).must_equal movie
    end
  end

  it 'must update' do
    movie = FactoryGirl.create :movie
    as_logged_in_moderator do
      post :update, :id => movie.friendly_id, :movie => FactoryGirl.attributes_for(:movie)
      response.status.must_equal 302
      flash[:notice].wont_be_nil
    end
  end

  it 'must create' do
    url = 'https://www.youtube.com/watch?v=0fCpAuxrQ_I'
    as_logged_in_user do
      VCR.use_cassette('movie_controller_test_create', :match_requests_on => [:method, VCR.request_matchers.uri_without_param(:key)]) do
        post :create, { :movie => {:url => url} }
        response.status.must_equal 302
        flash[:notice].wont_be_nil
        Movie.count.must_equal 1
      end
    end
  end

  it 'must redirect duplicates' do
    movie = FactoryGirl.create :real_youtube_id
    as_logged_in_user do
      VCR.use_cassette('movie_controller_test_create_duplicate', :match_requests_on => [:method, VCR.request_matchers.uri_without_param(:key)]) do
        post :create, { :movie => {:url => movie.youtube_id} }
      end
      response.status.must_equal 302
      flash[:alert].wont_be_nil
      Movie.count.must_equal 1
    end
  end

  it 'must handle non-youtube submissions gracefully' do
    url = 'http://example.com'
    as_logged_in_user do
      VCR.use_cassette('movie_controller_test_non_youtube_links', :match_requests_on => [:method, VCR.request_matchers.uri_without_param(:key)]) do
        post :create, { :movie => {:url => url} }
      end
    response.status.must_equal 302
    flash[:alert].wont_be_nil
    Movie.count.must_equal 0
    end
  end
end
