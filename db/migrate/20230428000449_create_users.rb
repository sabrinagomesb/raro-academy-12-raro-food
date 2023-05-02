# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 255
      t.string :cpf, null: false, limit: 11
      t.string :email, null: false, limit: 255
      t.string :password, null: false, limit: 255
      t.index %i[cpf email], unique: true

      t.timestamps
    end
  end
end
