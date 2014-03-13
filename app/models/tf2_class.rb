# == Schema Information
#
# Table name: tf2_classes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#
# Indexes
#
#  index_tf2_classes_on_slug  (slug) UNIQUE
#

class Tf2Class < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name,  :use => [:slugged, :history]
  validates :name,  :presence => true,
                    :uniqueness => true
  has_many  :movies

  def should_generate_new_friendly_id?
    name_changed?
  end
end
