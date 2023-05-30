class MoveDescriptionToActionText < ActiveRecord::Migration[7.0]
  def change
    Dish.all.find_each do |dish|
      dish.update(content: dish.description)
    end

    remove_column :dishes, :description
  end
end
