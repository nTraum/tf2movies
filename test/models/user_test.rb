require 'test_helper'

describe User do
  let (:nickname)           { 'Charlie' }
  let (:steam_profile_url)  { 'http://http://steamcommunity.com/id/Charlie/' }
  let (:uid)                { 12345678987654321 }
  let (:auth) { {
      'info' =>
        {
          'nickname'  => nickname,
          'urls'      => { 'Profile' => steam_profile_url }
        },
      'uid' => uid} }

  describe 'when created with omniauth' do
    subject { User.create_with_omniauth auth }

    it 'must be a User' do
      subject.must_be_instance_of User
    end
    it 'must be valid' do
      subject.valid?.must_equal true
    end
    it 'must have the correct nickname' do
      subject.nickname.must_equal nickname
    end
    it 'must have the correct profile url' do
      subject.steam_profile_url.must_equal steam_profile_url
    end
    it 'must have the correct steam id' do
      subject.steam_id.must_equal uid
    end
    it 'must be a user' do
      subject.user?.must_equal true
    end
  end

  describe 'online / offline' do
    it 'must be online when being active' do
      FactoryGirl.build(:online).online?.must_equal true
    end
    it 'must be offline when being inactive' do
      FactoryGirl.build(:offline).online?.must_equal false
    end
  end

  describe 'refresh login / online time' do
    subject {FactoryGirl.build :user}
    it 'must be able to refresh it\'s online time' do
      subject.refresh_last_online
      subject.last_online.must_be_within_delta(Time.current, 3)
    end
    it 'must be able to refresh it\'s login time' do
      subject.refresh_last_login
      subject.last_login.must_be_within_delta(Time.current, 3)
    end
  end

  describe 'refresh info' do
    user = FactoryGirl.build :user
    it 'must be able to refresh it\'s info from auth' do
      user.refresh_user_info auth
    end
    it 'must update the new nickname' do
      user.nickname.must_equal nickname
    end
    it 'must update the new steam profile url' do
      user.steam_profile_url.must_equal steam_profile_url
    end
  end

  describe 'staff' do
    it 'must recognize admins as a staff member' do
      FactoryGirl.build(:admin).staff?.must_equal true
    end
    it 'must recognize moderators as a staff member' do
      FactoryGirl.build(:moderator).staff?.must_equal true
    end
    it 'must recognize banned users not being a staff member' do
      FactoryGirl.build(:banned).staff?.must_equal false
    end
    it 'must recognize users not being a staff member' do
      FactoryGirl.build(:user).staff?.must_equal false
    end
  end
end