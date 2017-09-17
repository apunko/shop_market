class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.references :shop, foreign_key: true
      t.string :title, defalut: ""
      t.integer :amount, defalut: 1
      t.integer :price, defalut: 1

      t.timestamps
    end
  end
end
