class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :name, null: true, limit: 255
      t.string :public_place, null: false, limit: 255
      t.string :zip_code, null: false, limit: 8
      t.string :number, null: false, limit: 15
      t.string :neighborhood, null: false, limit: 255
      t.belongs_to :city, null: false, foreign_key: true
      t.references :addressable, polymorphic: true

      t.timestamps
    end
  end
end
