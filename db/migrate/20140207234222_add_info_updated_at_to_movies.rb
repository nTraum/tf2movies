class AddInfoUpdatedAtToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :info_refreshed_at, :datetime
  end
end
