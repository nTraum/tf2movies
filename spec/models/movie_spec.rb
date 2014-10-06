require "rails_helper"

RSpec.describe Movie, type: :model do
  describe "#thumbnail" do
    subject { described_class.new(youtube_id: "0fCpAuxrQ_I") }

    context "when specifying max quality" do
      specify { expect(subject.thumbnail(:max)).to eq "http://img.youtube.com/vi/0fCpAuxrQ_I/maxresdefault.jpg" }
    end

    context "when specifying high quality" do
      specify { expect(subject.thumbnail(:high)).to eq "http://img.youtube.com/vi/0fCpAuxrQ_I/sddefault.jpg" }
    end

    context "when specifying medium quality" do
      specify { expect(subject.thumbnail(:medium)).to eq "http://img.youtube.com/vi/0fCpAuxrQ_I/hqdefault.jpg" }
    end

    context "when specifying small quality" do
      specify { expect(subject.thumbnail(:small)).to eq "http://img.youtube.com/vi/0fCpAuxrQ_I/mqdefault.jpg" }
    end

    context "when specifying tiny quality" do
      specify { expect(subject.thumbnail(:tiny)).to eq "http://img.youtube.com/vi/0fCpAuxrQ_I/default.jpg" }
    end

    context "when specifying an unknown quality" do
      it "throws an ArgumentError" do
        expect{ subject.thumbnail(:foo) }.to raise_error(ArgumentError)
      end
    end
  end

  describe ".search" do
    it "returns a movie when it matches the title" do
      title = "7 brothers who aren't brothers"
      movie = create(:movie, title: title)

      expect(described_class.search(title)).to contain_exactly(movie)
    end

    it "returns a movie when it matches the description" do
      description = "TF2 frag movie"
      movie = create(:movie, description: description)

      expect(described_class.search(description)).to contain_exactly(movie)
    end

    it "ranks the title higher than the description" do
      query = "scout"
      movie_with_matching_title = create(:movie, title: query)
      movie_with_matching_description = create(:movie, description: query)

      search_result = described_class.search(query)

      expect(search_result.first).to eq(movie_with_matching_title)
      expect(search_result.second).to eq(movie_with_matching_description)
    end
  end

  describe "#featured_at" do
    it "is updated to the current timestamp when a movie is featured" do
      movie = create(:movie, featured: false)

      movie.update(featured: true)

      expect(movie.featured_at).to be_within(2).of(Time.now)
    end
  end
end
