class UseSimpleEnumForDownloads < ActiveRecord::Migration
  def up
    remove_column :downloads, :status
    add_column :downloads, :status_cd, :integer
  end
end
