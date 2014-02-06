class AddFeaturedAndFeaturedAtToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :featured, :boolean
    add_column :movies, :featured_at, :datetime
  end
end
