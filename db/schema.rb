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

ActiveRecord::Schema.define(version: 20171229192132) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calendars", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.integer "current_date", default: 1719739, null: false
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "occurred_on", null: false
    t.string "title", null: false
    t.integer "calendar_id"
    t.datetime "hidden_at"
    t.index ["calendar_id"], name: "index_events_on_calendar_id"
    t.index ["occurred_on"], name: "index_events_on_occurred_on"
  end

  create_table "invitations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "calendar_id"
    t.string "email"
    t.string "level"
    t.bigint "owner_id"
    t.datetime "accepted_at"
    t.index ["calendar_id"], name: "index_invitations_on_calendar_id"
    t.index ["email"], name: "index_invitations_on_email"
    t.index ["owner_id"], name: "index_invitations_on_owner_id"
  end

  create_table "password_resets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "token"
    t.index ["user_id"], name: "index_password_resets_on_user_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "calendar_id"
    t.bigint "user_id"
    t.string "level", default: "viewer"
    t.bigint "invitation_id"
    t.index ["calendar_id"], name: "index_permissions_on_calendar_id"
    t.index ["invitation_id"], name: "index_permissions_on_invitation_id"
    t.index ["user_id"], name: "index_permissions_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.index ["email"], name: "index_users_on_email"
  end

end
