# frozen_string_literal: true

class CreateVendors < ActiveRecord::Migration[8.0]
  def change
    create_table :vendors do |t|
      t.string :name, null: false
      t.string :category
      t.references :track, null: false, foreign_key: true

      t.timestamps
    end
  end
end
