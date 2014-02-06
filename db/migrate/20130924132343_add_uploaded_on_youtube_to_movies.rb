class AddUploadedOnYoutubeToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :uploaded_on_youtube, :datetime
  end
end
