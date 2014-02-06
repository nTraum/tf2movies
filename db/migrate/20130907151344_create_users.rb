class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :steam_id
      t.string :steam_profile_url
      t.datetime :last_logoin
      t.boolean :banned
      t.boolean :admin
      t.boolean :moderator

      t.timestamps
    end
  end
end
