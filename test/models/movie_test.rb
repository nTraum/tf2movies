require 'test_helper'

describe Movie do
  subject { FactoryGirl.build :real_youtube_id }

  it 'must be valid' do
    subject.valid?.must_equal true
  end

  describe 'thumbnails' do
    it 'must provide a thumbnail in max quality' do
      subject.thumbnail(:max).must_equal 'http://img.youtube.com/vi/0fCpAuxrQ_I/maxresdefault.jpg'
    end
    it 'must provide a thumbnail in high quality' do
      subject.thumbnail(:high).must_equal 'http://img.youtube.com/vi/0fCpAuxrQ_I/sddefault.jpg'
    end
    it 'must provide a thumbnail in medium quality' do
      subject.thumbnail(:medium).must_equal 'http://img.youtube.com/vi/0fCpAuxrQ_I/hqdefault.jpg'
    end
    it 'must provide a thumbnail in small quality' do
      subject.thumbnail(:small).must_equal 'http://img.youtube.com/vi/0fCpAuxrQ_I/mqdefault.jpg'
    end
    it 'must provide a thumbnail in tiny quality' do
      subject.thumbnail(:tiny).must_equal 'http://img.youtube.com/vi/0fCpAuxrQ_I/default.jpg'
    end
    it 'must raise an error when using an unknown size' do
      proc { subject.thumbnail(:foobar) }.must_raise ArgumentError
    end
  end

  describe 'new_with_url' do
      let (:user) { FactoryGirl.create :user }
    it 'must be created with an URL pointing to a YouTube movie' do
      url = 'https://www.youtube.com/watch?v=0fCpAuxrQ_I'
      VCR.use_cassette('movie_test_create', :match_requests_on => [:method, VCR.request_matchers.uri_without_param(:key)]) do
        movie = Movie.new_with_url(url, user)
        movie.valid?.must_equal true
      end
    end

    it 'must be invalid with an URL not pointing to a YouTube movie' do
      url = 'http://example.com'
      VCR.use_cassette('movie_test_create_invalid', :match_requests_on => [:method, VCR.request_matchers.uri_without_param(:key)]) do
        movie = Movie.new_with_url(url, user)
        movie.valid?.must_equal false
      end
    end
  end
end
