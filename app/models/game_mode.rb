# == Schema Information
#
# Table name: game_modes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class GameMode < ActiveRecord::Base
  validates :name,  :presence => true,
                    :uniqueness => true
  has_many  :movies
end
