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

ActiveRecord::Schema.define(version: 20150621152441) do

  create_table "achievements", force: :cascade do |t|
    t.string   "name"
    t.integer  "level"
    t.string   "url"
    t.integer  "criteria"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "repos", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "stars_count"
    t.integer  "forks_count"
    t.integer  "commits_count"
    t.string   "language"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "group_id"
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "token"
    t.string   "avatar_url"
    t.string   "location"
    t.integer  "followers"
    t.integer  "public_repos"
    t.integer  "public_gists"
    t.date     "start_date"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "flags"
    t.integer  "score"
    t.integer  "acct_age_level"
    t.integer  "languages_level"
    t.integer  "followers_level"
    t.integer  "repos_level"
    t.integer  "forks_level"
    t.integer  "commits_level"
    t.integer  "stars_level"
  end

end
