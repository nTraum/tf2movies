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

FactoryGirl.define do
  factory :author do
    nickname "nTraum"
    profile_url "https://www.youtube.com/user/nTraum"
    avatar_url "https://yt3.ggpht.com/-7F1zl7SCr6E/AAAAAAAAAAI/AAAAAAAAAAA/X3RrszRnbbw/s100-c-k-no/photo.jpg"
    youtube_id "nTraum"
  end
end
