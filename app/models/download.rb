# == Schema Information
#
# Table name: downloads
#
#  id         :integer          not null, primary key
#  url        :string(255)
#  movie_id   :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_downloads_on_movie_id  (movie_id)
#

class Download < ActiveRecord::Base
  belongs_to  :movie, :touch => true
  validates   :url,   :presence => true
  validates   :movie, :presence => true

  def host
    url.match(/(^http(s)?:\/\/)?(www\.)?(\w+\.)?(?<domain>\w+\.\w+)\//i)[:domain]
  end
end
