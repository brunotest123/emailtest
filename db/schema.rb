# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_08_08_123340) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "guests", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_guests_on_email", unique: true
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "shift_id"
    t.bigint "table_id"
    t.bigint "guest_id"
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
    t.integer "num_guests", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guest_id"], name: "index_reservations_on_guest_id"
    t.index ["shift_id"], name: "index_reservations_on_shift_id"
    t.index ["table_id"], name: "index_reservations_on_table_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_restaurants_on_email", unique: true
  end

  create_table "shifts", force: :cascade do |t|
    t.bigint "restaurant_id"
    t.string "name", null: false
    t.time "start_at", null: false
    t.time "end_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_shifts_on_restaurant_id"
  end

  create_table "tables", force: :cascade do |t|
    t.bigint "restaurant_id"
    t.string "name", null: false
    t.integer "minimun_guest", default: 1
    t.integer "maximun_guest", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_tables_on_restaurant_id"
  end

  add_foreign_key "reservations", "guests"
  add_foreign_key "reservations", "shifts"
  add_foreign_key "reservations", "tables"
  add_foreign_key "shifts", "restaurants"
  add_foreign_key "tables", "restaurants"
end
