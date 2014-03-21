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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :author do
    nickname 'Bobbie'
    profile_url "http://youtube.com/user/#{:nickname}"
    avatar_url 'http://lh6.googleusercontent.comA/x4F6AoofmFo/s88-c-k/photo.jpg'
    youtube_id 'pXQ1QdZ6RvdfhSFD56v57'
  end
end
