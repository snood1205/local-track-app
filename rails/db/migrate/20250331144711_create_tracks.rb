# frozen_string_literal: true

class CreateTracks < ActiveRecord::Migration[8.0]
  def change
    create_table :tracks do |t|
      t.string :name, null: false
      t.numeric :length, null: false
      t.string :length_unit, null: false
      t.string :material, null: false

      t.timestamps
    end
  end
end
