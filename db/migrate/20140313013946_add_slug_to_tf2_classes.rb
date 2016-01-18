class AddSlugToTf2Classes < ActiveRecord::Migration
  def change
    add_column :tf2_classes, :slug, :string
    add_index :tf2_classes, :slug, unique: true
  end
end
