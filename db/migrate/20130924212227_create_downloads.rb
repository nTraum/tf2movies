class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.string :url
      t.references :movie, index: true

      t.timestamps
    end
  end
end
