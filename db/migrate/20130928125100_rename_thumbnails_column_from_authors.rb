class RenameThumbnailsColumnFromAuthors < ActiveRecord::Migration
  def change
  rename_column :authors, :thumbnail_url, :avatar_url
  end
end
