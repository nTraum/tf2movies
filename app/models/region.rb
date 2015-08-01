# == Schema Information
#
# Table name: regions
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#
# Indexes
#
#  index_regions_on_slug  (slug) UNIQUE
#

class Region < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name,  use: [:slugged, :history]
  validates :name,  presence: true,
                    uniqueness: true
  validates :slug,  presence: true,
                    uniqueness: true
  has_many :movies

  def should_generate_new_friendly_id?
    name_changed?
  end
end
