class AddSlugToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :slug, :string
    add_index :movies, :slug, unique: true
  end
end
