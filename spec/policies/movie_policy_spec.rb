require "rails_helper"

describe MoviePolicy do
  let(:movie) { double("movie") }
  subject { described_class.new(user, movie) }

  shared_examples "every action is allowed" do
    it "is allowed to manage a movie" do
      expect(subject.manage?).to be(true)
    end

    it "is allowed to edit a movie" do
      expect(subject.edit?).to be(true)
    end

    it "is allowed to love a movie" do
      expect(subject.love?).to be(true)
    end

    it "is allowed to update a movie" do
      expect(subject.update?).to be(true)
    end

    it "is allowed to submit a movie" do
      expect(subject.submit?).to be(true)
    end

    it "is allowed to create a movie" do
      expect(subject.create?).to be(true)
    end
  end

  shared_examples "every action is disallowed" do
    it "is not allowed to manage a movie" do
      expect(subject.manage?).to be(false)
    end

    it "is not allowed to edit a movie" do
      expect(subject.edit?).to be(false)
    end

    it "is not allowed to love a movie" do
      expect(subject.love?).to be(false)
    end

    it "is not allowed to update a movie" do
      expect(subject.update?).to be(false)
    end

    it "is not allowed to submit a movie" do
      expect(subject.submit?).to be(false)
    end

    it "is not allowed to create a movie" do
      expect(subject.create?).to be(false)
    end
  end

  context "when the current user is anonymous" do
    let(:user) { nil }
    it_behaves_like "every action is disallowed"
  end

  context "when the current user is a registered user" do
    let(:user) { build(:user) }

    it "is not allowed to manage a movie" do
      expect(subject.manage?).to be(false)
    end

    it "is not allowed to edit a movie" do
      expect(subject.edit?).to be(false)
    end

    it "is allowed to love a movie" do
      expect(subject.love?).to be(true)
    end

    it "is not allowed to update a movie" do
      expect(subject.update?).to be(false)
    end

    it "is allowed to submit a movie" do
      expect(subject.submit?).to be(true)
    end

    it "is allowed to create a movie" do
      expect(subject.create?).to be(true)
    end
  end

  context "when the current user is a banned" do
    let(:user) { build(:user, role_cd: User.roles.banned) }
    it_behaves_like "every action is disallowed"
  end

  context "when the current user is a moderator" do
    let(:user) { build(:user, role_cd: User.roles.moderator) }
    it_behaves_like "every action is allowed"
  end

  context "when the current user is a an admin" do
    let(:user) { build(:user, role_cd: User.roles.admin) }
    it_behaves_like "every action is allowed"
  end
end
