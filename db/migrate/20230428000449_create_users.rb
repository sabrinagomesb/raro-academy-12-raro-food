class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 255
      t.string :cpf, null: false, limit: 11
      t.string :email, null: false, limit: 255
      t.string :password, null: false, limit: 255
      t.index [:cpf, :email], unique: true

      t.timestamps
    end
  end
end
