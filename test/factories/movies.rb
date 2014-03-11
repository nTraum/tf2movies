# == Schema Information
#
# Table name: movies
#
#  id                  :integer          not null, primary key
#  youtube_id          :string(255)
#  title               :string(255)
#  description         :text
#  views               :integer
#  duration            :integer
#  author_id           :integer
#  user_id             :integer
#  created_at          :datetime
#  updated_at          :datetime
#  uploaded_on_youtube :datetime
#  status              :string(255)
#  game_mode_id        :integer
#  tf2_class_id        :integer
#  featured            :boolean
#  featured_at         :datetime
#  info_refreshed_at   :datetime
#  region_id           :integer
#
# Indexes
#
#  index_movies_on_author_id     (author_id)
#  index_movies_on_game_mode_id  (game_mode_id)
#  index_movies_on_region_id     (region_id)
#  index_movies_on_user_id       (user_id)
#

FactoryGirl.define do
  sequence :youtube_id do |n|
    "abcdefgh#{n}"
  end

  factory :movie do
    youtube_id
    title 'foo'
    description 'bar'
    views 5
    duration 180
    author
    association :proposer, :factory => :user
    uploaded_on_youtube { 10.minutes.ago }
    featured false
    featured_at nil
    info_refreshed_at { DateTime.now }

    factory :real_youtube_id do
      youtube_id '0fCpAuxrQ_I'
    end
  end
end
