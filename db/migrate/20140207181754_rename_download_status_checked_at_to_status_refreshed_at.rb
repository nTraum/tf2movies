class RenameDownloadStatusCheckedAtToStatusRefreshedAt < ActiveRecord::Migration
  def change
    rename_column :downloads, :status_checked_at, :status_refreshed_at
  end
end
