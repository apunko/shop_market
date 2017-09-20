class AddLockVersionToPackages < ActiveRecord::Migration[5.1]
  def change
    add_column :packages, :lock_version, :integer
  end
end
