# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[8.0]
  def change
    create_table :payments do |t|
      t.string :transaction_code, null: false
      t.references :menu_item, null: true, foreign_key: true
      t.references :vendor, null: false, foreign_key: true
      t.integer :total_in_cents, null: false

      t.timestamps
    end

    add_index :menu_items, %i[id vendor_id], unique: true, name: 'unique_menu_item_vendor'

    add_foreign_key :payments, :menu_items, column: %i[menu_item_id vendor_id], primary_key: %i[id vendor_id],
                                            on_delete: :cascade, name: 'fk_menu_item_vendor'
  end
end
