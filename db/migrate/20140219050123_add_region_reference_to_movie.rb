class AddRegionReferenceToMovie < ActiveRecord::Migration
  def change
    add_reference :movies, :region, index: true
  end
end
