require 'test_helper'

describe Movie do
  subject { FactoryGirl.build :real_youtube_id }

  it 'must be valid' do
    subject.valid?.must_equal true
  end

  it 'must update meta data when being refreshed' do
    VCR.use_cassette('movie_test_refresh_info', :match_requests_on => [:method, VCR.request_matchers.uri_without_param(:key)]) do
      subject.refresh_info
    end
    subject.title.must_equal 'TF2 - 7 brothers (broder) frag movie'
    subject.description.must_equal 'Description'
    subject.views.must_equal 105304
    subject.info_refreshed_at.must_be_within_delta(Time.current, 3)
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

  it 'must be created with the YouTube API' do
    url = 'https://www.youtube.com/watch?v=0fCpAuxrQ_I'
    user = FactoryGirl.create :user
    movie = Movie.new
    VCR.use_cassette('movie_test_create', :match_requests_on => [:method, VCR.request_matchers.uri_without_param(:key)]) do
      movie.new_with_youtube_it(url, user)
    end
    movie.valid?.must_equal true
  end
end
