class CreateJoinTableCategoriesDishes < ActiveRecord::Migration[7.0]
  def change
    create_join_table :categories, :dishes do |t|
      t.index [:category_id, :dish_id], unique: true

      t.timestamps
    end
  end
end
