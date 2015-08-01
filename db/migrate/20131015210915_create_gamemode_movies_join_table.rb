class CreateGamemodeMoviesJoinTable < ActiveRecord::Migration
  def change
    create_table :game_modes_movies, id: false do |t|
      t.integer :game_mode_id
      t.integer :movies_id
    end
  end
end
