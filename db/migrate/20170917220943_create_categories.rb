class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.references :shop, foreign_key: true
      t.string :title, default: ""

      t.timestamps
    end
  end
end
