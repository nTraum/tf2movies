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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :steam_id do |n|
    Random.new.rand(99999999999)
  end

  sequence :steam_profile_url do |n|
    "http://steamcommunity.com/id/#{n}"
  end

  factory :user, :aliases => [:online] do
    nickname 'Bob'
    steam_id
    steam_profile_url
    last_login { 10.minutes.ago }
    last_online { 2.minutes.ago }
    role_cd User.roles.user
    factory :offline do
      last_login { 60.minutes.ago }
      last_online { 20.minutes.ago }
    end

    factory :moderator do
      role_cd User.roles.moderator
    end

    factory :admin do
      role_cd User.roles.admin
    end

    factory :banned do
      role_cd User.roles.banned
    end
  end
end
