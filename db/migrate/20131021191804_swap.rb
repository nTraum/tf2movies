class Swap < ActiveRecord::Migration
  def change
    remove_column :users, :steam_id
    rename_column :users, :steam_id_int, :steam_id
  end
end
