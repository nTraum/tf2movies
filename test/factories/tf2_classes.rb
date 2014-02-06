# == Schema Information
#
# Table name: tf2_classes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tf2_class do
    name 'Demoman'
  end
end
