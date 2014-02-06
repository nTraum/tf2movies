class AddStatusToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :status, :string
  end
end
