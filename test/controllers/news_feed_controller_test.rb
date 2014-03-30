require "test_helper"

describe NewsFeedController do
  describe 'feed' do
    it 'must provide an Atom feed' do
      FactoryGirl.create :movie
      get 'feed', { :format => :atom }
      response.status.must_equal 200
      assigns[:movies].wont_be_nil
    end

    it 'must provide a RSS feed' do
      get 'feed', { :format => :rss }
      response.status.must_equal 301
    end
  end
end
