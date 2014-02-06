class RenameUserIdColumnFromMovies < ActiveRecord::Migration
  def change
    rename_column :movies, :user_id, :proposer_id
  end
end
