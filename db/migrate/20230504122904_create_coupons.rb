# frozen_string_literal: true

class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :code, null: false, limit: 255
      t.string :name, null: false, limit: 255
      t.string :description, limit: 255
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.decimal :total_discount, null: false, precision: 8, scale: 2
      t.references :creator, null: false, foreign_key: { to_table: :administrators }

      t.timestamps
    end
  end
end
