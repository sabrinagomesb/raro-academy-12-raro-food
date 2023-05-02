# frozen_string_literal: true

class AddColumnsComplementAndReferenceToAddress < ActiveRecord::Migration[7.0]
  def change
    add_column :addresses, :reference, :string, null: true, limit: 255, after: :zip_code
    add_column :addresses, :complement, :string, null: true, limit: 255, after: :reference
  end
end
