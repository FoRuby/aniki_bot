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

ActiveRecord::Schema.define(version: 2021_03_08_114917) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "debts", force: :cascade do |t|
    t.bigint "creditor_id", null: false
    t.bigint "borrower_id"
    t.integer "value_kopecks", default: 0
    t.string "value_currency", default: "RUB", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_compensation", default: false
    t.index ["borrower_id"], name: "index_debts_on_borrower_id"
    t.index ["creditor_id"], name: "index_debts_on_creditor_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "date", null: false
    t.string "status", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "body", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "refills", force: :cascade do |t|
    t.string "status", null: false
    t.integer "value_kopecks", default: 0
    t.string "value_currency", default: "RUB", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "debt_id", null: false
    t.index ["debt_id"], name: "index_refills_on_debt_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "user_events", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.boolean "admin", default: false, null: false
    t.integer "payment_kopecks", default: 0
    t.string "payment_currency", default: "RUB", null: false
    t.integer "debt_kopecks", default: 0
    t.string "debt_currency", default: "RUB", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_user_events_on_event_id"
    t.index ["user_id", "event_id"], name: "index_user_events_on_user_id_and_event_id", unique: true
    t.index ["user_id"], name: "index_user_events_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.bigint "chat_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chat_id"], name: "index_users_on_chat_id"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "debts", "users", column: "creditor_id"
  add_foreign_key "notes", "users"
  add_foreign_key "refills", "debts"
  add_foreign_key "user_events", "events"
  add_foreign_key "user_events", "users"
end
