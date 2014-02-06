class RenameProposerIdColumnFromMovies < ActiveRecord::Migration
  def change
    rename_column :movies, :proposer_id, :user_id
  end
end
