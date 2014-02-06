# == Schema Information
#
# Table name: songs
#
#  id         :integer          not null, primary key
#  artist     :string(255)
#  title      :string(255)
#  movie_id   :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_songs_on_movie_id  (movie_id)
#

class Song < ActiveRecord::Base
  include Searchable

  belongs_to  :movie,   :touch => true
  validates   :artist,  :presence => true
  validates   :title,   :presence => true
  validates   :movie,   :presence => true

  def search_pattern
    "#{artist} - #{title}"
  end
end
