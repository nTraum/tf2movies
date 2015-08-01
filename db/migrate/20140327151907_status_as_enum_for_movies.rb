class StatusAsEnumForMovies < ActiveRecord::Migration
  def change
    remove_column :movies, :status
    add_column :movies, :status_cd, :integer

    Movie.all.each do |movie|
      movie.pending!
      movie.featured = false
      movie.featured_at = nil
      movie.save!
    end
  end
end
