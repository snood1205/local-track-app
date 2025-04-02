# frozen_string_literal: true

class AddSlugToVendor < ActiveRecord::Migration[8.0]
  def change
    add_column :vendors, :slug, :string, null: false, default: ''
    add_index :vendors, :slug, unique: true

    reversible do |dir|
      dir.up do
        Vendor.reset_column_information
        Vendor.find_each do |vendor|
          vendor.update(slug: vendor.name.parameterize)
        end
      end
    end
  end
end
