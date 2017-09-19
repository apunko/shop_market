class AddDescriptionToShops < ActiveRecord::Migration[5.1]
  def change
    add_column :shops, :description, :text, default: ""
  end
end
