class ChangeAssociationBetweenMoviesAndTf2Classes < ActiveRecord::Migration
  def change
    drop_table :movies_tf2_classes

    add_column :movies, :tf2_class_id, :integer, references: :tf2_class
  end
end
