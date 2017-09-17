class CreateOrderProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :order_products do |t|
      t.references :product, foreign_key: true
      t.references :order, foreign_key: true
      t.references :package, foreign_key: true
      t.integer :amount, default: 1
      
      t.timestamps
    end
  end
end
