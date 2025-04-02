# frozen_string_literal: true

class CreateMenuItems < ActiveRecord::Migration[8.0]
  def change
    create_table :menu_items do |t|
      t.string :name, null: false
      t.integer :price_in_cents, null: false
      t.string :heading
      t.string :description
      t.references :vendor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
