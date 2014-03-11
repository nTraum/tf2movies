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
    status 'unknown'
    status_refreshed_at nil
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

    factory :url_online_200 do
      url 'http://example.com'
    end

    factory :url_offline_404 do
      url 'http://example.com/test'
    end

    factory :url_offline_403 do
      url 'http://etf2l.org/wp-config.php.swp'
    end

    factory :url_offline_host_unknown do
      url 'vkfdgvdfslkghlkswlkvlkagqalkgwfq'
    end
  end
end
