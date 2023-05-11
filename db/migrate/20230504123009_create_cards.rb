# frozen_string_literal: true

class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :number, null: false, limit: 16
      t.string :name, null: false, limit: 255
      t.integer :security_code, null: false
      t.integer :card_type, null: false
      t.date :expiration_date, null: false
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
