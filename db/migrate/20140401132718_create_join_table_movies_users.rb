class CreateJoinTableMoviesUsers < ActiveRecord::Migration
  def change
    create_table :movies_users, id: false do |t|
      t.integer :movie_id,  null: false
      t.integer :user_id,   null: false
    end

    add_index(:movies_users, [:movie_id, :user_id], unique: true)
  end
end
