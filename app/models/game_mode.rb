# == Schema Information
#
# Table name: game_modes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#
# Indexes
#
#  index_game_modes_on_slug  (slug) UNIQUE
#

class GameMode < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name,  use: [:slugged, :history]
  validates :name,  presence: true,
                    uniqueness: true
  has_many :movies

  def should_generate_new_friendly_id?
    name_changed?
  end
end
