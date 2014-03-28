require 'test_helper'

describe YoutubeInfoProvider do
  let (:movie) { FactoryGirl.build :real_youtube_id}
  subject { YoutubeInfoProvider }

  it 'must update a movie' do
    VCR.use_cassette('youtube_info_provider_test_update_existing', :match_requests_on => [:method, VCR.request_matchers.uri_without_param(:key)]) do
      subject.update_movie!(movie)
    end
    movie.title.must_equal 'TF2 - 7 brothers (broder) frag movie'
    movie.description.must_equal 'Description.'
    movie.views.must_equal 105527
    movie.info_refreshed_at.must_be_within_delta(Time.current, 3)
  end
end