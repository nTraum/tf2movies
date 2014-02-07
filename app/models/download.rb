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

class Download < ActiveRecord::Base
  belongs_to  :movie,   :touch => true
  validates   :url,     :presence => true
  validates   :movie,   :presence => true
  validates   :status,  :inclusion => { :in => ['online', 'offline', 'unknown'] },
                        :presence => true

  before_validation :default_attributes

  def host
    url.match(/(^http(s)?:\/\/)?(www\.)?(\w+\.)?(?<domain>\w+\.\w+)\//i)[:domain]
  end

  def refresh_status
    begin
      resp = Curl::Easy.http_head(url) do |c|
        c.follow_location = true
        c.max_redirects = 10
      end
      case resp.response_code
        when 200
          self.status = 'online'
        when 404
          self.status = 'offline'
        else
          self.status = 'unknown'
      end
    rescue Curl::Err::CurlError
      self.status = 'offline'
    rescue
      self.status = 'unknown'
    ensure
      self.status_refreshed_at = DateTime.now
      save!
    end
  end

  def online?
    status == 'online'
  end

  def offline?
    status == 'offline'
  end

  def unknown?
    status == 'unknown'
  end

  private

  def default_attributes
    unless self.status
      self.status = 'unknown'
    end
  end
end
