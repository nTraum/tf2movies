# == Schema Information
#
# Table name: songs
#
#  id         :integer          not null, primary key
#  artist     :string(255)
#  title      :string(255)
#  movie_id   :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_songs_on_movie_id  (movie_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :song do
    artist 'Pixies'
    title 'Where Is My Mind'
    movie
  end
end
