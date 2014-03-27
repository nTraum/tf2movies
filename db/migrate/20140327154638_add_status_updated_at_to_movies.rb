class AddStatusUpdatedAtToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :status_changed_at, :datetime

    Movie.all.each do |movie|
      movie.status_changed_at = movie.created_at
      movie.featured = false
      movie.save!
    end
  end
end
