require "rails_helper"

RSpec.describe Author, type: :model do
  subject { create(:author) }
  describe ".search" do
    it "returns an author when it matches the nickname" do
      expect(described_class.search(subject.nickname)).to include(subject)
    end
  end

  it "generates a new friendly ID when the nickname has changed" do
    expect{ subject.update(nickname: "whatever") }
      .to change { subject.friendly_id }
  end
end
