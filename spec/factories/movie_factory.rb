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
#  game_mode_id        :integer
#  tf2_class_id        :integer
#  featured            :boolean
#  featured_at         :datetime
#  info_refreshed_at   :datetime
#  region_id           :integer
#  status_cd           :integer
#  status_changed_at   :datetime
#  slug                :string(255)
#
# Indexes
#
#  index_movies_on_author_id     (author_id)
#  index_movies_on_game_mode_id  (game_mode_id)
#  index_movies_on_region_id     (region_id)
#  index_movies_on_slug          (slug) UNIQUE
#  index_movies_on_tf2_class_id  (tf2_class_id)
#  index_movies_on_user_id       (user_id)
#

FactoryGirl.define do
  factory :movie do
    author
    sequence(:youtube_id, "0fCpAuxrQ_I")
    title "7 brothers who aren't brothers"
    description "Broder frag movie."
    views 5
    duration 3.minutes
    association :proposer, factory: :user
    uploaded_on_youtube { 1.day.ago }
    info_refreshed_at { 1.day.ago }
    featured false
    status :pending
  end
end
