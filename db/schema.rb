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

ActiveRecord::Schema.define(version: 20160727054906) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "beers", force: :cascade do |t|
    t.string   "name"
    t.integer  "ibu"
    t.integer  "abv"
    t.integer  "style_id"
    t.integer  "srmId"
    t.string   "brewery_id"
    t.string   "beer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "breweries", force: :cascade do |t|
    t.string   "name"
    t.string   "website"
    t.string   "address"
    t.string   "gpsLocation"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "brewery_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "locality"
    t.string   "description"
    t.string   "imgUrl"
    t.string   "province"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "group_id", default: rand 100000
    t.integer  "leader"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "styles", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "ibuMin"
    t.decimal  "ibuMax"
    t.decimal  "abvMin"
    t.decimal  "abvMax"
    t.decimal  "srmMin"
    t.decimal  "srmMax"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "style_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "password_digest"
    t.boolean  "admin",                                     default: false, null: false
    t.boolean  "banned",                                    default: false, null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.decimal  "lat",              precision: 10, scale: 6
    t.decimal  "lon",              precision: 10, scale: 6
    t.integer  "group_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
