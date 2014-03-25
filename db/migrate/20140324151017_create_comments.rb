class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.references :user, index: true
      t.references :movie, index: true
      t.boolean :hidden, default: false

      t.timestamps
    end
  end
end
