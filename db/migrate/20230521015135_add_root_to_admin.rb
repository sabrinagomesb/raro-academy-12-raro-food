# frozen_string_literal: true

class AddRootToAdmin < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :root, :boolean
  end
end
