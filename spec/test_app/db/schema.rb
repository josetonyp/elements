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

ActiveRecord::Schema.define(version: 20151209183947) do

  create_table "elements_attachments", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "alt",               limit: 255
    t.string   "title",             limit: 255
    t.string   "copy_right",        limit: 255
    t.string   "custom_attributes", limit: 255
    t.string   "html_class",        limit: 255
    t.string   "attachment_type",   limit: 255
    t.string   "file",              limit: 255
    t.string   "file_mime_type",    limit: 255
    t.string   "file_size",         limit: 255
    t.string   "file_url",          limit: 255
    t.integer  "creator_id",        limit: 4
    t.integer  "updater_id",        limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "attachable_id",     limit: 4
    t.string   "attachable_type",   limit: 255
    t.integer  "author",            limit: 4
  end

  add_index "elements_attachments", ["attachment_type"], name: "elements_attachments_attachment_type", using: :btree
  add_index "elements_attachments", ["file_url"], name: "elements_attachments_file_url", using: :btree

  create_table "elements_chip_translations", force: :cascade do |t|
    t.integer  "elements_chip_id", limit: 4,   null: false
    t.string   "locale",           limit: 255, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "value",            limit: 255
  end

  add_index "elements_chip_translations", ["elements_chip_id"], name: "index_elements_chip_translations_on_elements_chip_id", using: :btree
  add_index "elements_chip_translations", ["locale"], name: "index_elements_chip_translations_on_locale", using: :btree

  create_table "elements_chips", force: :cascade do |t|
    t.text     "value",          limit: 65535
    t.string   "key",            limit: 255
    t.string   "path",           limit: 255
    t.integer  "parent_id",      limit: 4
    t.integer  "lft",            limit: 4
    t.integer  "rgt",            limit: 4
    t.integer  "depth",          limit: 4
    t.integer  "children_count", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "creator_id",     limit: 4
    t.integer  "updater_id",     limit: 4
  end

  add_index "elements_chips", ["path"], name: "unique_elements_chips_attachment_path", unique: true, using: :btree

  create_table "elements_comments", force: :cascade do |t|
    t.integer  "content_id",     limit: 4
    t.text     "text",           limit: 65535
    t.integer  "creator_id",     limit: 4
    t.integer  "updater_id",     limit: 4
    t.datetime "publish_at"
    t.integer  "parent_id",      limit: 4
    t.integer  "lft",            limit: 4
    t.integer  "rgt",            limit: 4
    t.integer  "depth",          limit: 4
    t.integer  "children_count", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "elements_content_translations", force: :cascade do |t|
    t.integer  "elements_content_id", limit: 4,     null: false
    t.string   "locale",              limit: 255,   null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.text     "value",               limit: 65535
    t.text     "title",               limit: 65535
    t.text     "meta_title",          limit: 65535
    t.text     "meta_description",    limit: 65535
    t.text     "meta_keyword",        limit: 65535
    t.text     "excerpt",             limit: 65535
  end

  add_index "elements_content_translations", ["elements_content_id"], name: "index_elements_content_translations_on_elements_content_id", using: :btree
  add_index "elements_content_translations", ["locale"], name: "index_elements_content_translations_on_locale", using: :btree

  create_table "elements_contents", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.text     "value",            limit: 65535
    t.boolean  "multiline",                      default: false
    t.integer  "position",         limit: 4
    t.integer  "creator_id",       limit: 4
    t.integer  "updater_id",       limit: 4
    t.string   "path",             limit: 255
    t.string   "template",         limit: 255
    t.integer  "template_id",      limit: 4
    t.text     "title",            limit: 65535
    t.text     "meta_title",       limit: 65535
    t.text     "meta_description", limit: 65535
    t.text     "meta_keyword",     limit: 65535
    t.text     "excerpt",          limit: 65535
    t.string   "status",           limit: 255
    t.datetime "publish_at"
    t.string   "content_type",     limit: 255
    t.string   "latitude",         limit: 255
    t.string   "longitude",        limit: 255
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "elements_contents", ["content_type"], name: "elements_contents_content_type", using: :btree
  add_index "elements_contents", ["path"], name: "unique_elements_contents_path", unique: true, using: :btree
  add_index "elements_contents", ["publish_at"], name: "elements_contents_publish_at", using: :btree
  add_index "elements_contents", ["status"], name: "elements_contents_status", using: :btree

  create_table "elements_menu_translations", force: :cascade do |t|
    t.integer  "elements_menu_id",  limit: 4,   null: false
    t.string   "locale",            limit: 255, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "name",              limit: 255
    t.string   "label",             limit: 255
    t.string   "title",             limit: 255
    t.string   "subtitle",          limit: 255
    t.string   "icon_class",        limit: 255
    t.string   "custom_attributes", limit: 255
  end

  add_index "elements_menu_translations", ["elements_menu_id"], name: "index_elements_menu_translations_on_elements_menu_id", using: :btree
  add_index "elements_menu_translations", ["locale"], name: "index_elements_menu_translations_on_locale", using: :btree

  create_table "elements_menus", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "label",             limit: 255
    t.string   "title",             limit: 255
    t.string   "url",               limit: 255
    t.string   "target",            limit: 255
    t.string   "subtitle",          limit: 255
    t.string   "icon_class",        limit: 255
    t.string   "custom_attributes", limit: 255
    t.integer  "content_id",        limit: 4
    t.integer  "parent_id",         limit: 4
    t.integer  "lft",               limit: 4
    t.integer  "rgt",               limit: 4
    t.integer  "depth",             limit: 4
    t.integer  "children_count",    limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "creator_id",        limit: 4
    t.integer  "updater_id",        limit: 4
  end

  create_table "elements_users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "creator_id",             limit: 4
    t.integer  "updater_id",             limit: 4
    t.datetime "published"
    t.string   "title",                  limit: 255
    t.string   "display_name",           limit: 255
    t.text     "resume",                 limit: 65535
    t.string   "picture",                limit: 255
    t.string   "avatar",                 limit: 255
    t.string   "name",                   limit: 255
    t.string   "lastname",               limit: 255
  end

  add_index "elements_users", ["email"], name: "index_elements_users_on_email", unique: true, using: :btree
  add_index "elements_users", ["reset_password_token"], name: "index_elements_users_on_reset_password_token", unique: true, using: :btree

  create_table "elements_versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255,        null: false
    t.integer  "item_id",    limit: 4,          null: false
    t.string   "event",      limit: 255,        null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object",     limit: 4294967295
    t.datetime "created_at"
  end

  add_index "elements_versions", ["item_type", "item_id"], name: "index_elements_versions_on_item_type_and_item_id", using: :btree

end
