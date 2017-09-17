class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :shop, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :status, default: 0
      t.integer :price

      t.timestamps
    end
  end
end
