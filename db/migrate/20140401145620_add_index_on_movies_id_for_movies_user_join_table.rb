class AddIndexOnMoviesIdForMoviesUserJoinTable < ActiveRecord::Migration
  def change
    add_index :movies_users, :movie_id
  end
end
