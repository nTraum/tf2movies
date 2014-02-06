# == Schema Information
#
# Table name: tf2_classes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Tf2Class < ActiveRecord::Base
  validates :name,  :presence => true,
                    :uniqueness => true
  has_many  :movies
end
