require "rails_helper"

RSpec.describe Song, type: :model do
  let(:artist) { "artist" }
  let(:title)  { "title" }

  subject { described_class.new(artist: artist, title: title) }

  describe "#song_pattern" do
    it "returns the artist and title seperated by a dash" do
      expect(subject.search_pattern).to eq("#{artist} - #{title}")
    end
  end

  describe "#google_search" do
    it "returns the query URL for Google" do
      expect(subject.google_search).to eq("http://google.com/search?q=artist+-+title")
    end
  end

  describe "#youtube_search" do
    it "returns the query URL for YouTube" do
      expect(subject.youtube_search).to eq("http://youtube.com/results?search_query=artist+-+title")
    end
  end

  describe "#soundcloud_search" do
    it "returns the query URL for Soundcloud" do
      expect(subject.soundcloud_search).to eq("http://soundcloud.com/search?q=artist+-+title")
    end
  end
end
