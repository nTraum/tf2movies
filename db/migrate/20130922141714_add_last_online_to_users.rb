class AddLastOnlineToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_online, :datetime
  end
end
