# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141106155358) do

  create_table "assets", force: true do |t|
    t.integer  "item_id"
    t.string   "mime"
    t.string   "url"
    t.string   "title"
    t.string   "alt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "channels", force: true do |t|
    t.string   "type"
    t.string   "name"
    t.text     "description"
    t.integer  "entity_id"
    t.boolean  "primary"
    t.string   "service_identifier"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_polled_at"
    t.integer  "service_identifier_id"
  end

  create_table "channels_keywords", force: true do |t|
    t.integer "channel_id"
    t.integer "keyword_id"
  end

  create_table "channels_tags", force: true do |t|
    t.integer "channel_id"
    t.integer "tag_id"
  end

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "organization"
    t.string   "url"
    t.string   "phone"
    t.string   "email"
    t.integer  "contactable_id"
    t.string   "contactable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entities", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
  end

  add_index "entities", ["parent_id"], name: "index_entities_on_parent_id"

  create_table "entities_keywords", force: true do |t|
    t.integer "entity_id"
    t.integer "keyword_id"
  end

  create_table "entities_users", force: true do |t|
    t.integer  "entity_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.string   "title"
    t.integer  "channel_id"
    t.text     "description"
    t.string   "link"
    t.string   "guid"
    t.datetime "published_at"
    t.text     "raw"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "keywords", force: true do |t|
    t.string   "name"
    t.string   "display_name"
    t.text     "description"
    t.integer  "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manifests", force: true do |t|
    t.integer  "entity_id"
    t.string   "url"
    t.text     "last_response"
    t.datetime "succeded_at"
    t.datetime "fetched_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "fullname"
    t.datetime "last_sign_in_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.boolean  "admin",                  default: false
    t.boolean  "blocked"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
