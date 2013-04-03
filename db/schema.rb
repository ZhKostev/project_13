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

ActiveRecord::Schema.define(version: 20130403184631) do

  create_table "admins", force: true do |t|
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true

  create_table "articles", force: true do |t|
    t.string   "title"
    t.string   "meta_description"
    t.string   "short_description"
    t.string   "language"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "origin_id"
  end

  add_index "articles", ["origin_id"], name: "articles_origin_id_index"
  add_index "articles", ["slug"], name: "index_articles_on_slug"

  create_table "articles_rubrics", id: false, force: true do |t|
    t.integer "article_id", null: false
    t.integer "rubric_id",  null: false
  end

  add_index "articles_rubrics", ["article_id", "rubric_id"], name: "index_articles_rubrics_on_article_id_and_rubric_id", unique: true

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "rubrics", force: true do |t|
    t.string   "language"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "rubrics", ["slug"], name: "index_rubrics_on_slug"

end
