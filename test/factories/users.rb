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
#  role              :string(255)
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
    role 'user'
    last_online { 2.minutes.ago }

    factory :offline do
      last_login { 60.minutes.ago }
      last_online { 20.minutes.ago }
    end

    factory :moderator do
      role 'moderator'
    end

    factory :admin do
      role 'admin'
    end

    factory :banned do
      role 'banned'
    end
  end
end
