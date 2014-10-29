require "rails_helper"

describe GameModePolicy do
  let(:category) { double("category") }
  subject { described_class.new(user, category) }

  shared_examples "every administration action is disallowed" do
    it "is not allowed to manage a category" do
      expect(subject.manage?).to be(false)
    end

    it "is not allowed to edit a category" do
      expect(subject.edit?).to be(false)
    end

    it "is not allowed to update a category" do
      expect(subject.update?).to be(false)
    end

    it "is not allowed to destroy a category" do
      expect(subject.destroy?).to be(false)
    end

    it "is not allowed to create a category" do
      expect(subject.create?).to be(false)
    end

    it "is not allowed to initialize a category" do
      expect(subject.new?).to be(false)
    end
  end

  shared_examples "every administration action is allowed" do
    it "is allowed to manage a category" do
      expect(subject.manage?).to be(true)
    end

    it "is allowed to edit a category" do
      expect(subject.edit?).to be(true)
    end

    it "is allowed to update a category" do
      expect(subject.update?).to be(true)
    end

    it "is allowed to destroy a category" do
      expect(subject.destroy?).to be(true)
    end

    it "is allowed to create a category" do
      expect(subject.create?).to be(true)
    end

    it "is allowed to initialize a category" do
      expect(subject.new?).to be(true)
    end
  end

  context "when the current user is anonymous" do
    let(:user) { nil }
    it_behaves_like "every administration action is disallowed"
  end

  context "when the current user is a registered user" do
    let(:user) { build(:user) }
    it_behaves_like "every administration action is disallowed"
  end

  context "when the current user is a banned" do
    let(:user) { build(:user, role_cd: User.roles.banned) }
    it_behaves_like "every administration action is disallowed"
  end

  context "when the current user is a moderator" do
    let(:user) { build(:user, role_cd: User.roles.moderator) }
    it_behaves_like "every administration action is disallowed"
  end

  context "when the current user is a an admin" do
    let(:user) { build(:user, role_cd: User.roles.admin) }
    it_behaves_like "every administration action is allowed"
  end
end
