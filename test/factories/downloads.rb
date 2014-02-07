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
    url 'http://fakkelbrigade.eu/torden/7brothers_720pHi'
    movie
    status 'online'
    status_refreshed_at { DateTime.now }
    factory :no_prefix do
      url 'fakkelbrigade.eu/torden/7brothers_720pHi'
    end

    factory :https do
      url 'https://fakkelbrigade.eu/torden/7brothers_720pHi'
    end

    factory :subdomain do
      url 'files.fakkelbrigade.eu/torden/7brothers_720pHi'
    end

    factory :http_www do
      url 'http://www.fakkelbrigade.eu/torden/7brothers_720pHi'
    end
    factory :https_www do
      url 'https://www.fakkelbrigade.eu/torden/7brothers_720pHi'
    end

    factory :no_status_check do
      status_refreshed_at nil
      status 'unknown'
    end
  end
end
