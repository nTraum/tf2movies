class AddAssociationBetweenMoviesAndTf2Classes < ActiveRecord::Migration
  def change
    create_table :movies_tf2_classes, :id => false do |t|
      t.belongs_to :movie
      t.belongs_to :tf2_class
    end
  end
end
