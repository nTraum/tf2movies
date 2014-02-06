class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :youtube_id
      t.string :title
      t.text :description
      t.integer :views
      t.integer :duration
      t.references :author
      t.references :user

      t.timestamps
    end
  end
end
