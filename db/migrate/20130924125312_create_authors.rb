class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :nickname
      t.string :profile_url
      t.string :thumbnail_url

      t.timestamps
    end
  end
end
