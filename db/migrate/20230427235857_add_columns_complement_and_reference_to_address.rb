# frozen_string_literal: true

class AddColumnsComplementAndReferenceToAddress < ActiveRecord::Migration[7.0]
  def change
    change_table :addresses, bulk: true do |t|
      t.string :reference, null: true, limit: 255, after: :zip_code
      t.string :complement, null: true, limit: 255, after: :reference
    end
  end
end
