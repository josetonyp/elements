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

ActiveRecord::Schema.define(version: 20150917160645) do

  create_table "elements_attachments", force: :cascade do |t|
    t.string   "name"
    t.string   "alt"
    t.string   "title"
    t.string   "copy_right"
    t.string   "creator"
    t.string   "custom_attributes"
    t.string   "html_class"
    t.string   "attachment_type"
    t.string   "file"
    t.string   "file_mime_type"
    t.string   "file_size"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "elements_attachments", ["attachment_type"], name: "elements_attachments_attachment_type"

  create_table "elements_chip_translations", force: :cascade do |t|
    t.integer  "elements_chip_id", null: false
    t.string   "locale",           null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "value"
  end

  add_index "elements_chip_translations", ["elements_chip_id"], name: "index_elements_chip_translations_on_elements_chip_id"
  add_index "elements_chip_translations", ["locale"], name: "index_elements_chip_translations_on_locale"

  create_table "elements_chips", force: :cascade do |t|
    t.text     "value"
    t.string   "key"
    t.string   "path"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.integer  "children_count"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "elements_chips", ["path"], name: "unique_elements_chips_attachment_path", unique: true

  create_table "elements_content_translations", force: :cascade do |t|
    t.integer  "elements_content_id", null: false
    t.string   "locale",              null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.text     "value"
    t.text     "title"
    t.text     "meta_title"
    t.text     "meta_description"
    t.text     "meta_keyword"
    t.text     "excerpt"
  end

  add_index "elements_content_translations", ["elements_content_id"], name: "index_elements_content_translations_on_elements_content_id"
  add_index "elements_content_translations", ["locale"], name: "index_elements_content_translations_on_locale"

  create_table "elements_contents", force: :cascade do |t|
    t.string   "name"
    t.text     "value"
    t.boolean  "multiline",        default: false
    t.integer  "position"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "path"
    t.string   "template"
    t.integer  "template_id"
    t.text     "title"
    t.text     "meta_title"
    t.text     "meta_description"
    t.text     "meta_keyword"
    t.text     "excerpt"
    t.string   "status"
    t.string   "publish_at"
    t.string   "content_type"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "elements_contents", ["content_type"], name: "elements_contents_content_type"
  add_index "elements_contents", ["path"], name: "unique_elements_contents_path", unique: true
  add_index "elements_contents", ["publish_at"], name: "elements_contents_publish_at"
  add_index "elements_contents", ["status"], name: "elements_contents_status"

  create_table "elements_menu_translations", force: :cascade do |t|
    t.integer  "elements_menu_id",  null: false
    t.string   "locale",            null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "name"
    t.string   "label"
    t.string   "title"
    t.string   "subtitle"
    t.string   "icon_class"
    t.string   "custom_attributes"
  end

  add_index "elements_menu_translations", ["elements_menu_id"], name: "index_elements_menu_translations_on_elements_menu_id"
  add_index "elements_menu_translations", ["locale"], name: "index_elements_menu_translations_on_locale"

  create_table "elements_menus", force: :cascade do |t|
    t.string   "name"
    t.string   "label"
    t.string   "title"
    t.string   "url"
    t.string   "target"
    t.string   "subtitle"
    t.string   "icon_class"
    t.string   "custom_attributes"
    t.integer  "content_id"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.integer  "children_count"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "elements_versions", force: :cascade do |t|
    t.string   "item_type",                     null: false
    t.integer  "item_id",                       null: false
    t.string   "event",                         null: false
    t.string   "whodunnit"
    t.text     "object",     limit: 1073741823
    t.datetime "created_at"
  end

  add_index "elements_versions", ["item_type", "item_id"], name: "index_elements_versions_on_item_type_and_item_id"

end
