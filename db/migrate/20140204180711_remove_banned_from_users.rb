class RemoveBannedFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :banned
  end
end
