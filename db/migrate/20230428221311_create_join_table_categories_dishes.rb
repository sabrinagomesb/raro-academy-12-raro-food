# frozen_string_literal: true

class CreateJoinTableCategoriesDishes < ActiveRecord::Migration[7.0]
  def change
    create_join_table :categories, :dishes do |t|
      t.index %i[category_id dish_id], unique: true

      t.timestamps
    end
  end
end
