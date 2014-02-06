class ChangeUserColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :last_logoin, :last_login
  end
end
