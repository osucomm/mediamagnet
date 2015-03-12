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

ActiveRecord::Schema.define(version: 20150312204119) do

  create_table "assets", force: :cascade do |t|
    t.integer  "item_id",    null: false
    t.string   "mime"
    t.text     "url",        null: false
    t.string   "title"
    t.string   "alt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "size"
  end

  add_index "assets", ["item_id"], name: "index_assets_on_item_id"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "template",    default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "channels", force: :cascade do |t|
    t.string   "type",                                null: false
    t.string   "name",                                null: false
    t.text     "description"
    t.integer  "entity_id",                           null: false
    t.boolean  "primary"
    t.string   "service_identifier"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_polled_at"
    t.integer  "service_identifier_id"
    t.text     "avatar_url"
    t.integer  "max_refresh_interval",  default: 300
  end

  add_index "channels", ["entity_id"], name: "index_channels_on_entity_id"
  add_index "channels", ["type"], name: "index_channels_on_type"

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "organization"
    t.string   "url"
    t.string   "phone"
    t.string   "email"
    t.integer  "contactable_id",   null: false
    t.string   "contactable_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["contactable_id", "contactable_type"], name: "index_contacts_on_contactable_id_and_contactable_type"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "entities", force: :cascade do |t|
    t.string   "name",                        null: false
    t.text     "description"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.boolean  "approved",    default: false
  end

  add_index "entities", ["approved"], name: "index_entities_on_approved"
  add_index "entities", ["parent_id"], name: "index_entities_on_parent_id"

  create_table "entities_users", force: :cascade do |t|
    t.integer  "entity_id",  null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entities_users", ["entity_id"], name: "index_entities_users_on_entity_id"
  add_index "entities_users", ["user_id"], name: "index_entities_users_on_user_id"

  create_table "events", force: :cascade do |t|
    t.integer  "item_id",     null: false
    t.integer  "location_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["end_date"], name: "index_events_on_end_date"
  add_index "events", ["item_id"], name: "index_events_on_item_id"
  add_index "events", ["location_id"], name: "index_events_on_location_id"
  add_index "events", ["start_date"], name: "index_events_on_start_date"

  create_table "identities", force: :cascade do |t|
    t.string   "uid"
    t.string   "provider"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id"

  create_table "items", force: :cascade do |t|
    t.string   "title"
    t.integer  "channel_id",        null: false
    t.text     "description"
    t.string   "guid"
    t.datetime "published_at"
    t.text     "raw"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content"
    t.string   "source_identifier"
    t.string   "digest"
  end

  add_index "items", ["channel_id"], name: "index_items_on_channel_id"
  add_index "items", ["published_at"], name: "index_items_on_published_at"

  create_table "items_links", force: :cascade do |t|
    t.integer  "item_id",    null: false
    t.integer  "link_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items_links", ["item_id"], name: "index_items_links_on_item_id"
  add_index "items_links", ["link_id"], name: "index_items_links_on_link_id"

  create_table "keyword_usages", force: :cascade do |t|
    t.integer  "keyword_id",              null: false
    t.integer  "channel_id",              null: false
    t.integer  "count",       default: 0
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "week_number"
    t.integer  "year"
  end

  add_index "keyword_usages", ["channel_id"], name: "index_keyword_usages_on_channel_id"
  add_index "keyword_usages", ["count"], name: "index_keyword_usages_on_count"
  add_index "keyword_usages", ["keyword_id"], name: "index_keyword_usages_on_keyword_id"

  create_table "keywordings", force: :cascade do |t|
    t.string   "keywordable_type", null: false
    t.integer  "keywordable_id",   null: false
    t.integer  "keyword_id",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "keywordings", ["keyword_id"], name: "index_keywordings_on_keyword_id"
  add_index "keywordings", ["keywordable_id", "keywordable_type"], name: "index_keywordings_on_keywordable_id_and_keywordable_type"

  create_table "keywords", force: :cascade do |t|
    t.string   "name",         null: false
    t.string   "display_name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  add_index "keywords", ["category_id"], name: "index_keywords_on_category_id"
  add_index "keywords", ["name"], name: "index_keywords_on_name"

  create_table "links", force: :cascade do |t|
    t.string   "url",        null: false
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "location"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mappings", force: :cascade do |t|
    t.integer  "mappable_id",   null: false
    t.string   "mappable_type", null: false
    t.integer  "tag_id",        null: false
    t.integer  "keyword_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  add_index "mappings", ["keyword_id"], name: "index_mappings_on_keyword_id"
  add_index "mappings", ["mappable_id", "mappable_type"], name: "index_mappings_on_mappable_id_and_mappable_type"
  add_index "mappings", ["tag_id"], name: "index_mappings_on_tag_id"
  add_index "mappings", ["type"], name: "index_mappings_on_type"

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id",  null: false
    t.integer "item_id", null: false
  end

  add_index "taggings", ["item_id"], name: "index_taggings_on_item_id"
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id"

  create_table "tags", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tokens", force: :cascade do |t|
    t.string   "access_token"
    t.string   "refresh_token"
    t.string   "expires_at"
    t.integer  "channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
  end

  add_index "tokens", ["channel_id"], name: "index_tokens_on_channel_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                             null: false
    t.string   "name"
    t.datetime "last_sign_in_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sign_in_count",     default: 0,     null: false
    t.boolean  "admin",             default: false
    t.boolean  "blocked",           default: false
    t.integer  "current_entity_id"
  end

  add_index "users", ["admin"], name: "index_users_on_admin"
  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
