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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :download do
    url 'http://example.com/test.mp4'
    movie

    factory :http_download do
      # Alias for :download
    end

    factory :missing_protocol_download do
      url 'example.com/test.mp4'
    end

    factory :https_download do
      url 'https://example.com/test.mp4'
    end

    factory :subdomain_download do
      url 'test.example.com/test.mp4'
    end

    factory :http_www_download do
      url 'http://www.example.com/test.mp4'
    end

    factory :https_www_download do
      url 'https://www.example.com/test.mp4'
    end
  end
end
