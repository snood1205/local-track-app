# frozen_string_literal: true

class AddSlugToMenuItems < ActiveRecord::Migration[8.0]
  def change
    add_column :menu_items, :slug, :string, null: false, default: ''

    reversible do |dir|
      dir.up do
        MenuItem.reset_column_information
        MenuItem.find_each do |menu_item|
          menu_item.update(slug: menu_item.name.parameterize)
        end
      end
    end

    add_index :menu_items, :slug, unique: true
  end
end
