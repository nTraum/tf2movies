# == Schema Information
#
# Table name: downloads
#
#  id                  :integer          not null, primary key
#  url                 :string(255)
#  movie_id            :integer
#  created_at          :datetime
#  updated_at          :datetime
#  status              :string(255)
#  status_refreshed_at :datetime
#
# Indexes
#
#  index_downloads_on_movie_id  (movie_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :download do
    url 'http://example.com/test.mp4'
    movie
    status 'online'
    status_refreshed_at { DateTime.now }
    factory :no_prefix do
      url 'example.com/test.mp4'
    end

    factory :https do
      url 'https://example.com/test.mp4'
    end

    factory :subdomain do
      url 'test.example.com/test.mp4'
    end

    factory :http_www do
      url 'http://www.example.com/test.mp4'
    end
    factory :https_www do
      url 'https://www.example.com/test.mp4'
    end

    factory :no_status_check do
      url 'http://example.com'
      status_refreshed_at nil
      status 'unknown'
    end
  end
end
