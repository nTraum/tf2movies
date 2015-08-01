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
  as_enum :status,    unknown: 0, online: 1, offline: 2
  belongs_to :movie,     touch: true
  validates :url,       presence: true
  validates :movie,     presence: true
  validates :status,    presence: true

  before_validation :default_attributes

  def host
    url.match(/(^http(s)?:\/\/)?(www\.)?(\w+\.)?(?<domain>\w+\.\w+)\//i)[:domain]
  end

  private

  def default_attributes
    self.unknown! unless status
  end
end
