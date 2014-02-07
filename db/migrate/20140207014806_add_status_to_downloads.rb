class AddStatusToDownloads < ActiveRecord::Migration
  def change
    add_column    :downloads, :status, :string
    remove_column :downloads, :online
  end
end
