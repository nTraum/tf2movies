class CreateTf2Classes < ActiveRecord::Migration
  def change
    create_table :tf2_classes do |t|
      t.string :name

      t.timestamps
    end
  end
end
