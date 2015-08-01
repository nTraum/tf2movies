class ChangeUsersSteamIdColumnToInteger < ActiveRecord::Migration
  def change
    add_column :users, :steam_id_int, :integer, limit: 8
  end
end
