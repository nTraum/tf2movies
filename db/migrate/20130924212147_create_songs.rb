class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :artist
      t.string :title
      t.references :movie, index: true

      t.timestamps
    end
  end
end
