require "rails_helper"

RSpec.describe Author, type: :model do
  describe ".search" do
    it "returns an author when it matches the nickname" do
      nickname = "Bob"
      author = create(:author, nickname: nickname)

      expect(described_class.search(nickname)).to contain_exactly(author)
    end
  end

  it "generates a new friendly ID when the nickname has changed" do
    author = create(:author)
    new_nickname = "foo"

    expect{ author.update(nickname: new_nickname) }.to change { author.friendly_id }
  end
end
