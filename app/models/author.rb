# == Schema Information
#
# Table name: authors
#
#  id          :integer          not null, primary key
#  nickname    :string(255)
#  profile_url :string(255)
#  avatar_url  :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  youtube_id  :string(255)
#  slug        :string(255)
#
# Indexes
#
#  index_authors_on_slug  (slug) UNIQUE
#

class Author < ActiveRecord::Base
  include PgSearch
  extend FriendlyId

  pg_search_scope :search,      :against => :nickname,
                                :using => { :tsearch => {:prefix => true} }

  friendly_id     :nickname,    :use => [:slugged]
  has_many        :movies

  validates       :nickname,    :presence => true
  validates       :profile_url, :presence => true
  validates       :avatar_url,  :presence => true
  validates       :youtube_id,  :presence => true

  def should_generate_new_friendly_id?
    nickname_changed? || slug.nil?
  end
end
