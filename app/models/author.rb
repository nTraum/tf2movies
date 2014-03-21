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
  extend FriendlyId
  friendly_id :nickname,  :use => [:slugged]
  has_many    :movies

  validates   :nickname,    :presence => true
  validates   :profile_url, :presence => true
  validates   :avatar_url,  :presence => true
  validates   :youtube_id,  :presence => true

  def self.create_with_youtube_it(author_info)
    create! do |author|
      author.nickname = author_info.username
      author.profile_url = "http://youtube.com/user/#{author_info.username}"
      author.avatar_url = author_info.avatar
      author.youtube_id = author_info.user_id
    end
  end

  def should_generate_new_friendly_id?
    nickname_changed? || slug.nil?
  end
end
