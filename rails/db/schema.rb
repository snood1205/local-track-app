# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_04_02_140808) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "street_line1", null: false
    t.string "street_line2"
    t.string "city", null: false
    t.string "region"
    t.string "postal_code"
    t.string "country", null: false
    t.bigint "track_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["track_id"], name: "index_addresses_on_track_id", unique: true
  end

  create_table "menu_items", force: :cascade do |t|
    t.string "name", null: false
    t.integer "price_in_cents", null: false
    t.string "heading"
    t.string "description"
    t.bigint "vendor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vendor_id"], name: "index_menu_items_on_vendor_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "length", null: false
    t.string "length_unit", null: false
    t.string "material", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name", null: false
    t.string "category"
    t.bigint "track_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug", default: "", null: false
    t.index ["slug"], name: "index_vendors_on_slug", unique: true
    t.index ["track_id"], name: "index_vendors_on_track_id"
  end

  add_foreign_key "addresses", "tracks"
  add_foreign_key "menu_items", "vendors"
  add_foreign_key "vendors", "tracks"
end
