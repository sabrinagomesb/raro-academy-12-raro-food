class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :dish, null: false, foreign_key: true
      t.integer :amount, null: false, default: 1
      t.decimal :unit_price, null: false, precision: 8, scale: 2

      t.timestamps
    end
  end
end
