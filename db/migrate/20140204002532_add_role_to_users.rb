class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string
    remove_column :users, :admin
    remove_column :users, :moderator
  end
end
