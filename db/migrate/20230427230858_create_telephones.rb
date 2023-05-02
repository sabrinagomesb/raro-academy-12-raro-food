# frozen_string_literal: true

class CreateTelephones < ActiveRecord::Migration[7.0]
  def change
    create_table :telephones do |t|
      t.string :number, null: false, limit: 11
      t.references :contactable, polymorphic: true

      t.timestamps
    end
  end
end
