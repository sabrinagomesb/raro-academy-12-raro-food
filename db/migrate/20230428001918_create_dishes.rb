class CreateDishes < ActiveRecord::Migration[7.0]
  def change
    create_table :dishes do |t|
      t.references :chef, null: false, foreign_key: true
      t.string :name, null: false, limit: 255
      t.text :description, null: false
      t.boolean :available, null: false, default: false
      t.boolean :active, null: false, default: false
      t.decimal :unit_price, null: false, precision: 8, scale: 2

      t.timestamps
    end
  end
end
