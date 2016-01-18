# == Schema Information
#
# Table name: downloads
#
#  id                  :integer          not null, primary key
#  url                 :string(255)
#  movie_id            :integer
#  created_at          :datetime
#  updated_at          :datetime
#  status_refreshed_at :datetime
#  filesize            :integer
#  status_cd           :integer
#
# Indexes
#
#  index_downloads_on_movie_id  (movie_id)
#

FactoryGirl.define do
  factory :download do
    sequence(:url, "http://example.com/a")
    movie
  end
end
