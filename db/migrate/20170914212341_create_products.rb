class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :title, default: ""
      t.references :shop, foreign_key: true
      t.text :description, default: ""

      t.timestamps
    end
  end
end
