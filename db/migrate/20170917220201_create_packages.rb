class CreatePackages < ActiveRecord::Migration[5.1]
  def change
    create_table :packages do |t|
      t.references :product, foreign_key: true
      t.string :title, default: ""
      t.integer :amount, default: 0

      t.timestamps
    end
  end
end
