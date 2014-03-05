# == Schema Information
#
# Table name: regions
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Region < ActiveRecord::Base
  validates :name,  :presence => true,
                    :uniqueness => true
  has_many :movies
end
