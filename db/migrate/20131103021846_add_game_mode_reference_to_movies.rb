class AddGameModeReferenceToMovies < ActiveRecord::Migration
  def change
    add_reference :movies, :game_mode, index: true

    drop_table :game_modes_movies
  end
end
