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
#  game_mode_id        :integer
#  tf2_class_id        :integer
#  featured            :boolean
#  featured_at         :datetime
#  info_refreshed_at   :datetime
#  region_id           :integer
#  status_cd           :integer
#  status_changed_at   :datetime
#  slug                :string(255)
#
# Indexes
#
#  index_movies_on_author_id     (author_id)
#  index_movies_on_game_mode_id  (game_mode_id)
#  index_movies_on_region_id     (region_id)
#  index_movies_on_slug          (slug) UNIQUE
#  index_movies_on_tf2_class_id  (tf2_class_id)
#  index_movies_on_user_id       (user_id)
#

class Movie < ActiveRecord::Base
  include PgSearch
  extend FriendlyId
  pg_search_scope :search, against: { title: "A", description: "B" },
                           using: { tsearch: { prefix: true } }

  friendly_id :slug_canditates, use: [:slugged, :history]
  as_enum :status, pending: 0, rejected: 1, published: 2
  belongs_to :proposer, class_name: "User", foreign_key: "user_id", touch: true
  belongs_to :author,                                               touch: true
  has_many :downloads, dependent: :destroy
  has_many :songs, dependent: :destroy
  has_many :comments
  belongs_to :game_mode
  belongs_to :tf2_class
  belongs_to :region
  has_and_belongs_to_many :users

  accepts_nested_attributes_for :songs, :downloads, reject_if: :all_blank, allow_destroy: true

  validates :status,                    presence: true
  validates :youtube_id,                presence: { message: "No movie found." },
                                        uniqueness: { message: "Movie has already been submitted." }
  validates :title,                     presence: true
  validates :views,                     numericality: { greater_than_or_equal_to: 0 },
                                        presence: true
  validates :duration,                  numericality: { greater_than_or_equal_to: 0 },
                                        presence: true
  validates :uploaded_on_youtube,       presence: true
  validates :proposer,                  presence: true
  validates :author,                    presence: true
  validates :featured,                  inclusion: [true, false]
  validates :featured_at,               presence: true, if: :featured?
  validates :info_refreshed_at,         presence: true
  validates :status_changed_at,         presence: true

  before_validation :update_featured_at,        if: proc { |m| m.featured_changed? && m.featured? }
  before_validation :update_status_changed_at,  if: :status_changed?

  scope :featured, -> { where(featured: true) }

  def self.new_with_url(url, proposer)
    new do |movie|
      movie.proposer = proposer
      movie.featured = false
      movie.pending!
      YoutubeInfoProvider.update_movie(movie, url)
    end
  end

  def slug_canditates
    [:title, [:title, :youtube_id]]
  end

  def should_generate_new_friendly_id?
    title_changed? || slug.nil?
  end

  def thumbnail(quality = :tiny)
    sizes = {
      max: "maxresdefault", # 1280x720
      high: "sddefault",     # 640x480
      medium: "hqdefault",     # 480x360
      small: "mqdefault",     # 320x180
      tiny: "default"        # 120x90
    }

    fail ArgumentError, "unknown quality '#{quality}'" unless sizes[quality]
    "http://img.youtube.com/vi/#{youtube_id}/#{sizes[quality]}.jpg"
  end

  private

  def update_featured_at
    self.featured_at = Time.zone.now
  end

  def update_status_changed_at
    self.status_changed_at = Time.zone.now
  end
end
