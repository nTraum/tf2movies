# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  text       :text
#  user_id    :integer
#  movie_id   :integer
#  hidden     :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_comments_on_movie_id  (movie_id)
#  index_comments_on_user_id   (user_id)
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  validates   :text,  :presence => true
  validates   :movie, :presence => true
  validates   :user,  :presence => true

  before_validation :sanitize_text


  def sanitize_text
    self.text = Sanitize.clean(self.text, Sanitize::Config::BASIC)
  end
end
