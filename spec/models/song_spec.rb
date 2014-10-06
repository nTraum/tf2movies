require "rails_helper"

RSpec.describe Song, type: :model do
  describe "#song_pattern" do
    it "returns the artist and title seperated by a dash" do
      artist = "artist"
      title = "title"

      song = described_class.new(artist: artist, title: title)

      expect(song.search_pattern).to eq("artist - title")
    end
  end
end
