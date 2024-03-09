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

ActiveRecord::Schema[7.0].define(version: 2024_03_09_165235) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contact_media", force: :cascade do |t|
    t.string "rank"
    t.bigint "contact_id", null: false
    t.bigint "medium_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_contact_media_on_contact_id"
    t.index ["medium_id"], name: "index_contact_media_on_medium_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "relationship", default: "friend"
    t.string "email"
    t.string "phone_number"
    t.string "address"
    t.string "social_media_handle", default: "@ig_name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.integer "status", default: 0
    t.datetime "requested_at"
    t.datetime "responded_at"
    t.bigint "user_id", null: false
    t.bigint "friend_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["user_id"], name: "index_friendships_on_user_id"
  end

  create_table "interactions", force: :cascade do |t|
    t.datetime "interaction_date"
    t.bigint "user_id", null: false
    t.bigint "contact_id", null: false
    t.bigint "medium_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_interactions_on_contact_id"
    t.index ["medium_id"], name: "index_interactions_on_medium_id"
    t.index ["user_id"], name: "index_interactions_on_user_id"
  end

  create_table "media", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_media_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.string "text"
    t.bigint "interaction_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["interaction_id"], name: "index_notes_on_interaction_id"
  end

  create_table "reminders", force: :cascade do |t|
    t.string "frequency_unit"
    t.integer "frequency_quantity"
    t.boolean "done"
    t.string "reminderable_type", null: false
    t.bigint "reminderable_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reminderable_type", "reminderable_id"], name: "index_reminders_on_reminderable"
    t.index ["user_id"], name: "index_reminders_on_user_id"
  end

  create_table "user_settings", force: :cascade do |t|
    t.string "preferred_languages"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_settings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "nickname"
    t.string "emoji"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "contact_media", "contacts"
  add_foreign_key "contact_media", "media"
  add_foreign_key "contacts", "users"
  add_foreign_key "friendships", "users"
  add_foreign_key "friendships", "users", column: "friend_id"
  add_foreign_key "interactions", "contacts"
  add_foreign_key "interactions", "media"
  add_foreign_key "interactions", "users"
  add_foreign_key "media", "users"
  add_foreign_key "notes", "interactions"
  add_foreign_key "reminders", "users"
  add_foreign_key "user_settings", "users"
end
