require "test_helper"

describe SearchController do

  describe 'search' do
    it 'must find movies by their title' do
      movie = FactoryGirl.create :movie
      get :search, :q => movie.title
      response.status.must_equal 200
      assigns(:movies).size.wont_equal 0

    end
    it 'must find authors by their nickname' do
      author = FactoryGirl.create :author
      get :search, :q => author.nickname
      response.status.must_equal 200
      assigns(:authors).size.wont_equal 0
    end
    it 'must find users by their nickname' do
      user = FactoryGirl.create :user
      get :search, :q => user.nickname
      response.status.must_equal 200
      assigns(:users).size.wont_equal 0
    end
  end
end
