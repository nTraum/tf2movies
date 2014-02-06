require 'test_helper'

describe Author do
  describe 'create with author info' do
    let(:username)  { 'Bob' }
    let(:avatar)    { 'http://ytavatar.com/google/dsd.jpg' }
    let(:user_id)   { 'bob' }
    let(:auth_info) { OpenStruct.new :username => username, :avatar => avatar, :user_id => user_id }
    subject         { Author.create_with_youtube_it auth_info }

    it 'must be valid' do
      subject.must_be_instance_of Author
      subject.valid?.must_equal true
    end
    it 'must have the correct nickname' do
      subject.nickname.must_equal username
    end
    it 'must have the correct profile url' do
      subject.profile_url.must_equal "http://youtube.com/user/#{username}"
    end
    it 'must have the correct avatar url' do
      subject.avatar_url.must_equal avatar
    end
    it 'must have the correct youtube id' do
      subject.youtube_id.must_equal user_id
    end
  end
end
