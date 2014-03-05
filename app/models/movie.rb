# == Schema Information
#
# Table name: movies
#
#  id                  :integer          not null, primary key
#  youtube_id          :string(255)
#  title               :string(255)
#  description         :text
#  views               :integer
#  duration            :integer
#  author_id           :integer
#  user_id             :integer
#  created_at          :datetime
#  updated_at          :datetime
#  uploaded_on_youtube :datetime
#  status              :string(255)
#  game_mode_id        :integer
#  tf2_class_id        :integer
#  featured            :boolean
#  featured_at         :datetime
#  info_refreshed_at   :datetime
#  region_id           :integer
#
# Indexes
#
#  index_movies_on_author_id     (author_id)
#  index_movies_on_game_mode_id  (game_mode_id)
#  index_movies_on_region_id     (region_id)
#  index_movies_on_user_id       (user_id)
#

class Movie < ActiveRecord::Base
  belongs_to    :proposer,            :class_name => 'User', :foreign_key => 'user_id',
                                      :touch => true
  belongs_to    :author,              :touch => true
  has_many      :downloads
  has_many      :songs
  belongs_to    :game_mode
  belongs_to    :tf2_class
  belongs_to    :region

  accepts_nested_attributes_for       :songs, :downloads, :reject_if => :all_blank, :allow_destroy => true

  validates     :youtube_id,          :presence => true,
                                      :uniqueness => {:message => 'has already been submitted.'}
  validates     :title,               :presence => true
  validates     :views,               :numericality => {:greater_than_or_equal_to => 0},
                                      :presence => true
  validates     :duration,            :numericality => {:greater_than_or_equal_to => 0},
                                      :presence => true
  validates     :uploaded_on_youtube, :presence => true
  validates     :proposer,            :presence => true
  validates     :author,              :presence => true
  validates     :info_refreshed_at,   :presence => true
  scope :featured, -> { where(:featured => true) }

  def refresh_info
    youtube_client = YouTubeIt::Client.new(:dev_key => ENV['YOUTUBE_API_KEY'])
    movie_info = youtube_client.video_by(youtube_id)
    self.title = movie_info.title
    self.description = movie_info.description
    self.views = movie_info.view_count
    self.info_refreshed_at = DateTime.now
    save!
  end

  def self.new_with_youtube_it(url, user)
    youtube_client = YouTubeIt::Client.new(:dev_key => ENV['YOUTUBE_API_KEY'])
    movie_info = youtube_client.video_by(url)
    author_info = youtube_client.profile movie_info.author.uri.split('/').last #YOLO
    new do |movie|
      movie.author = Author.where(:youtube_id => author_info.user_id).first || Author.create_with_youtube_it(author_info)
      movie.proposer = user
      movie.youtube_id = movie_info.unique_id
      movie.title = movie_info.title
      movie.description = movie_info.description
      movie.views = movie_info.view_count
      movie.duration = movie_info.duration
      movie.uploaded_on_youtube = movie_info.uploaded_at
      movie.info_refreshed_at = DateTime.now
    end
  end
end
