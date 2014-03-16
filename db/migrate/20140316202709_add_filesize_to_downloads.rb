class AddFilesizeToDownloads < ActiveRecord::Migration
  def change
    add_column :downloads, :filesize, :bigint
  end
end
