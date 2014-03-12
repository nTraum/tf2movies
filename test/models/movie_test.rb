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
end
