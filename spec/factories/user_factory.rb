FactoryGirl.define do
  factory :user do
    sequence(:nickname, "nTraum")
    steam_profile_url { "http://steamcommunity.com/id/#{nickname}" }
    last_login { 1.day.ago }
    last_online { 1.day.ago }
    sequence(:steam_id, 0)
    role_cd User.roles.user
  end
end
