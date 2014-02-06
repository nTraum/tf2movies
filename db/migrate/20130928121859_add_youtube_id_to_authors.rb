class AddYoutubeIdToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :youtube_id, :string
  end
end
