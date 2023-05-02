# frozen_string_literal: true

class CreateChefs < ActiveRecord::Migration[7.0]
  def change
    create_table :chefs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :address, null: false, foreign_key: true
      t.references :approver, null: false, foreign_key: { to_table: :administrators }

      t.timestamps
    end
  end
end
