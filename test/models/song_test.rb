require 'test_helper'

describe Song do
  subject { FactoryGirl.build :song }

  it 'must be valid' do
    subject.must_be_instance_of Song
    subject.valid?.must_equal true
  end

  it 'must provide a search pattern' do
    subject.search_pattern.must_equal 'Pixies - Where Is My Mind'
  end

  it 'must be searchable with Google' do
    subject.google_search.must_equal 'http://google.com/search?q=Pixies+-+Where+Is+My+Mind'
  end

  it 'must be searchable with YouTube' do
    subject.youtube_search.must_equal 'http://youtube.com/results?search_query=Pixies+-+Where+Is+My+Mind'
  end

  it 'must be searchable with SoundCloud' do
    subject.soundcloud_search.must_equal 'http://soundcloud.com/search?q=Pixies+-+Where+Is+My+Mind'
  end
end
