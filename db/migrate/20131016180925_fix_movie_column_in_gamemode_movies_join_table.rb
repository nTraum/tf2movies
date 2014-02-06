class FixMovieColumnInGamemodeMoviesJoinTable < ActiveRecord::Migration
  def change
    rename_column :game_modes_movies, :movies_id, :movie_id
  end
end
