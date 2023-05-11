# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.integer :payment_type, null: false
      t.string :state, null: false
      t.references :order, null: false, foreign_key: true
      t.references :card, null: true, foreign_key: true

      t.timestamps
    end
  end
end
