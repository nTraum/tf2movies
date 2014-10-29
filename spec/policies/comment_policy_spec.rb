require "rails_helper"

describe CommentPolicy do
  subject { described_class.new(user, comment) }

  shared_examples "an action allowed for registered users and staff" do |action|
    let(:comment) { double("comment") }

    context "when the current user is anonymous" do
      let(:user) { nil }
      specify { expect(subject.public_send(action)).to be(false) }
    end

    context "when the current user is a registered user" do
      let(:user) { build(:user) }
      specify { expect(subject.public_send(action)).to be(true) }
    end

    context "when the current user is banned" do
      let(:user) { build(:user, role_cd: User.roles.banned) }
      specify { expect(subject.public_send(action)).to be(false) }
    end

    context "when the current user is a moderator" do
      let(:user) { build(:user, role_cd: User.roles.moderator) }
      specify { expect(subject.public_send(action)).to be(true) }
    end

    context "when the current user is an admin" do
      let(:user) { build(:user, role_cd: User.roles.admin) }
      specify { expect(subject.public_send(action)).to be(true) }
    end
  end

  shared_examples "an action allowed when the user is registered and is the author" do
    let(:comment) { double("comment") }

    context "when the current user is anonymous" do
      let(:user) { nil }
      specify { expect(subject.edit?).to be(false) }
    end

    context "when the current user is a registered user" do
      let!(:user) { create(:user) }
      let!(:other_user) { create(:user) }

      context "and when the comment was created by the same user" do
        let(:comment) { user.comments.new }
        specify { expect(subject.edit?).to be(true) }
      end

      context "and when the comment was created by a different user" do
        let(:comment) { other_user.comments.new }
        specify { expect(subject.edit?).to be(false) }
      end
    end
  end

  describe "#create?" do
    it_behaves_like "an action allowed for registered users and staff", :create?
  end

  describe "#new?" do
    it_behaves_like "an action allowed for registered users and staff", :new?
  end

  describe "#edit?" do
    it_behaves_like "an action allowed when the user is registered and is the author"
  end

  describe "#update?" do
    it_behaves_like "an action allowed when the user is registered and is the author"
  end
end
