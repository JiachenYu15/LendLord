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

ActiveRecord::Schema.define(version: 2018_12_02_033620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friends", force: :cascade do |t|
    t.bigint "user_from_id"
    t.bigint "user_to_id"
    t.boolean "has_accepted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_from_id"], name: "index_friends_on_user_from_id"
    t.index ["user_to_id"], name: "index_friends_on_user_to_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "deposit", precision: 10, scale: 2
    t.boolean "is_available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.boolean "is_deleted"
    t.string "image_link"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rater"
    t.integer "ratee"
    t.integer "transaction_id"
    t.integer "score"
  end

  create_table "transactions", force: :cascade do |t|
    t.date "start_date"
    t.date "due_date"
    t.decimal "deposit", precision: 10, scale: 2
    t.string "status"
    t.bigint "item_id"
    t.bigint "user_id"
    t.index ["item_id"], name: "index_transactions_on_item_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.text "fname"
    t.text "lname"
    t.text "address"
    t.text "home_number"
    t.text "cell_number"
    t.string "remember_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "friends", "users", column: "user_from_id"
  add_foreign_key "friends", "users", column: "user_to_id"
end
