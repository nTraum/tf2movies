require "rails_helper"

RSpec.describe User, type: :model do
  describe ".search" do
    it "returns a user when it matches the nickname" do
      nickname = "Bob"

      user = create(:user, nickname: nickname)

      expect(described_class.search(nickname)).to contain_exactly(user)
    end
  end

  describe "#refresh_user_info" do
    let(:omniauth_hash) do
      {
        "info" => {
          "nickname" => subject.nickname,
          "urls" => { "Profile" => subject.steam_profile_url }
        }
      }
    end

    subject { create(:user) }
    context "when the nickname changed" do
      it "updates the nickname" do
        new_nickname = "Alice"
        omniauth_hash["info"]["nickname"] = new_nickname

        expect { subject.refresh_user_info(omniauth_hash) }.to change { subject.nickname }.to(new_nickname)
      end
    end
    context "when the steam profile url changed" do
      it "updates the steam profile url" do
        new_steam_profile_url = "http://steamcommunity.com/id/Alice"
        omniauth_hash["info"]["urls"]["Profile"] = new_steam_profile_url

        expect do
          subject.refresh_user_info(omniauth_hash)
        end.to change { subject.steam_profile_url }.to(new_steam_profile_url)
      end
    end
  end

  describe ".create_with_omniauth" do
    let(:nickname) { "Bob" }
    let(:uid) { "12345" }
    let(:profile) { "http://steamcommunity.com/id/#{nickname}" }
    let(:omniauth_hash) do
      {
        "info" => {
          "nickname" => nickname,
          "urls" => { "Profile" => profile }
        },
        "uid" => uid
      }
    end
    subject { described_class.create_with_omniauth(omniauth_hash) }

    it "sets the nickname" do
      expect(subject.nickname).to eq(nickname)
    end

    it "parses the uid to an integer and sets it as the SteamID" do
      expect(subject.steam_id).to eq(uid.to_i)
    end

    it "sets the steam profile url" do
      expect(subject.steam_profile_url).to eq(profile)
    end

    it "sets the user role to a normal user" do
      expect(subject).to be_user
    end

    it "sets the last login to now" do
      expect(subject.last_login).to be_within(2).of(Time.zone.now)
    end

    it "sets the last online to now" do
      expect(subject.last_online).to be_within(2).of(Time.zone.now)
    end

    it "persists the user" do
      expect(subject).to be_persisted
    end
  end

  describe "#refresh_last_online" do
    context "when the last_online timestamp is older than 5 minutes"
    subject { create(:user, last_online: 6.minutes.ago) }
    it "updates the last_online timestamp to to now" do
      subject.refresh_last_online
      expect(subject.last_online).to be_within(2).of(Time.zone.now)
    end
    context "when the last_online timestamp is younger than 5 minutes" do
      subject { create(:user, last_online: 1.minute.ago) }
      it "does not update the last_online timestamp" do
        expect { subject.refresh_last_online }.not_to change { subject.last_online }
      end
    end
  end

  describe "#refresh_last_login" do
    subject { create(:user) }
    it "sets the last_login date to now" do
      subject.refresh_last_login
      expect(subject.last_login).to be_within(2).of(Time.zone.now)
    end
  end

  describe "#online?" do
    it "is true when the user was last_online less than 10 minutes ago" do
      user = build(:user, last_online: 5.minutes.ago)

      expect(user).to be_online
    end

    it "is false when the user last_online more than 10 minutes ago" do
      user = build(:user, last_online: 15.minutes.ago)

      expect(user).to_not be_online
    end
  end

  describe "#staff?" do
    context "when the user is an admin" do
      specify { expect(build(:user, role: :admin)).to be_staff }
    end

    context "when the user is a mderator" do
      specify { expect(build(:user, role: :moderator)).to be_staff }
    end

    context "when the user is a normal user" do
      specify { expect(build(:user, role: :user)).to_not be_staff }
    end

    context "when the user is banned" do
      specify { expect(build(:user, role: :banned)).to_not be_staff }
    end
  end
end
