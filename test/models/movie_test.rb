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

  it 'must provide thumbnail URLs in 5 sizes' do
    subject.thumbnail(:max).must_equal 'http://img.youtube.com/vi/0fCpAuxrQ_I/maxresdefault.jpg'
    subject.thumbnail(:high).must_equal 'http://img.youtube.com/vi/0fCpAuxrQ_I/sddefault.jpg'
    subject.thumbnail(:medium).must_equal 'http://img.youtube.com/vi/0fCpAuxrQ_I/hqdefault.jpg'
    subject.thumbnail(:small).must_equal 'http://img.youtube.com/vi/0fCpAuxrQ_I/mqdefault.jpg'
    subject.thumbnail(:tiny).must_equal 'http://img.youtube.com/vi/0fCpAuxrQ_I/default.jpg'
  end
end
