class AddOnlineToDownloads < ActiveRecord::Migration
  def change
    add_column :downloads, :online, :boolean
  end
end
