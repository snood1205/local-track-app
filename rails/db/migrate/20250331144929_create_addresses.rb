# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.string :street_line1, null: false
      t.string :street_line2
      t.string :city, null: false
      t.string :region # state, province, canton, etc.
      t.string :postal_code
      t.string :country, null: false
      t.belongs_to :track, null: false, foreign_key: true, index: { unique: true }

      t.timestamps
    end
  end
end
