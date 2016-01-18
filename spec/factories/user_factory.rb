# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  nickname          :string(255)
#  steam_profile_url :string(255)
#  last_login        :datetime
#  created_at        :datetime
#  updated_at        :datetime
#  last_online       :datetime
#  steam_id          :integer
#  role_cd           :integer
#

FactoryGirl.define do
  factory :user do
    sequence(:nickname, "nTraum")
    steam_profile_url { "http://steamcommunity.com/id/#{nickname}" }
    last_login { 1.day.ago }
    last_online { 1.day.ago }
    sequence(:steam_id, 0)
    role :user
  end
end
