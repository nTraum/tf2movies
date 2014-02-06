class CreateGameModes < ActiveRecord::Migration
  def change
    create_table :game_modes do |t|
      t.string :name

      t.timestamps
    end
  end
end
