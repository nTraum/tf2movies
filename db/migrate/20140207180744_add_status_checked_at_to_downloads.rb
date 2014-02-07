class AddStatusCheckedAtToDownloads < ActiveRecord::Migration
  def change
    add_column :downloads, :status_checked_at, :datetime
  end
end
