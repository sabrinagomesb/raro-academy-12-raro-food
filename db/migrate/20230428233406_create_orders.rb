class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: :true
      t.references :delivery_address, null: false, foreign_key: { to_table: :addresses }
      t.decimal :total_price, null: false, precision: 8, scale: 2, default: 0
      t.integer :status, null: false, default: 1

      t.timestamps
    end
  end
end
