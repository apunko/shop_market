class AddBlockedToShops < ActiveRecord::Migration[5.1]
  def change
    add_column :shops, :blocked, :boolean, default: false
  end
end
