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

ActiveRecord::Schema.define(version: 20140313012946) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: true do |t|
    t.string   "nickname"
    t.string   "profile_url"
    t.string   "avatar_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "youtube_id"
  end

  create_table "downloads", force: true do |t|
    t.string   "url"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.datetime "status_refreshed_at"
  end

  add_index "downloads", ["movie_id"], name: "index_downloads_on_movie_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "game_modes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "game_modes", ["slug"], name: "index_game_modes_on_slug", unique: true, using: :btree

  create_table "movies", force: true do |t|
    t.string   "youtube_id"
    t.string   "title"
    t.text     "description"
    t.integer  "views"
    t.integer  "duration"
    t.integer  "author_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "uploaded_on_youtube"
    t.string   "status"
    t.integer  "game_mode_id"
    t.integer  "tf2_class_id"
    t.boolean  "featured"
    t.datetime "featured_at"
    t.datetime "info_refreshed_at"
    t.integer  "region_id"
  end

  add_index "movies", ["author_id"], name: "index_movies_on_author_id", using: :btree
  add_index "movies", ["game_mode_id"], name: "index_movies_on_game_mode_id", using: :btree
  add_index "movies", ["region_id"], name: "index_movies_on_region_id", using: :btree
  add_index "movies", ["user_id"], name: "index_movies_on_user_id", using: :btree

  create_table "regions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "regions", ["slug"], name: "index_regions_on_slug", unique: true, using: :btree

  create_table "songs", force: true do |t|
    t.string   "artist"
    t.string   "title"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "songs", ["movie_id"], name: "index_songs_on_movie_id", using: :btree

  create_table "tf2_classes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "nickname"
    t.string   "steam_profile_url"
    t.datetime "last_login"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_online"
    t.integer  "steam_id",          limit: 8
    t.string   "role"
  end

end
