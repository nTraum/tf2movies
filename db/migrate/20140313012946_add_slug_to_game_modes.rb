class AddSlugToGameModes < ActiveRecord::Migration
  def change
    add_column :game_modes, :slug, :string
    add_index :game_modes, :slug, unique: true
  end
end
