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

class Download < ActiveRecord::Base
  as_enum     :status,    :unknown => 0, :online => 1, :offline => 2
  belongs_to  :movie,     :touch => true
  validates   :url,       :presence => true
  validates   :movie,     :presence => true
  validates   :status,    :as_enum => true

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
          self.online!
          self.filesize = resp.downloaded_content_length.to_i
        when 404
          self.offline!
        else
          self.unknown!
      end
    rescue
      self.unknown!
    ensure
      self.status_refreshed_at = DateTime.now
      self.save!
    end
  end

  private

  def default_attributes
    unless self.status
      self.unknown!
    end
  end
end
