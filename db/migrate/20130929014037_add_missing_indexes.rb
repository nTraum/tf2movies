class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :movies, :user_id
    add_index :movies, :author_id
  end
end
