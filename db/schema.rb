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

ActiveRecord::Schema.define(version: 20141023203935) do

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
    t.datetime "fetched_at"
    t.text     "raw"
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

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "fullname"
    t.datetime "last_sign_in_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
