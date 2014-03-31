class AddMissingIndexOnTf2ClassIdForMovies < ActiveRecord::Migration
  def change
    add_index :movies, :tf2_class_id
  end
end
