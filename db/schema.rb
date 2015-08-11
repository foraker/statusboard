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

ActiveRecord::Schema.define(version: 20150810195247) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "announcements", force: :cascade do |t|
    t.text     "words"
    t.string   "user"
    t.datetime "announced_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "pivotal_epic_stories", force: :cascade do |t|
    t.integer "story_id"
    t.integer "epic_id"
  end

  add_index "pivotal_epic_stories", ["epic_id"], name: "index_pivotal_epic_stories_on_epic_id", using: :btree
  add_index "pivotal_epic_stories", ["story_id"], name: "index_pivotal_epic_stories_on_story_id", using: :btree

  create_table "pivotal_epics", force: :cascade do |t|
    t.integer "project_id"
    t.integer "pivotal_id"
    t.integer "label_id"
    t.string  "name"
    t.string  "url"
  end

  add_index "pivotal_epics", ["project_id"], name: "index_pivotal_epics_on_project_id", using: :btree

  create_table "pivotal_projects", force: :cascade do |t|
    t.integer "pivotal_id"
    t.text    "name"
    t.text    "point_scale"
  end

  create_table "pivotal_stories", force: :cascade do |t|
    t.integer  "pivotal_id"
    t.integer  "project_id"
    t.datetime "started_at"
    t.datetime "accepted_at"
    t.string   "url"
    t.integer  "estimate"
    t.text     "name"
    t.text     "description"
    t.string   "kind"
    t.string   "story_type"
    t.text     "labels"
    t.string   "current_state"
    t.text     "tags",          default: [], array: true
  end

  add_index "pivotal_stories", ["project_id"], name: "index_pivotal_stories_on_project_id", using: :btree

  create_table "pull_requests", force: :cascade do |t|
    t.string   "github_id"
    t.string   "repository"
    t.string   "title"
    t.string   "author"
    t.integer  "size"
    t.integer  "thumbs"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "closed_at"
    t.string   "url"
  end

  create_table "tweets", force: :cascade do |t|
    t.string   "twitter_id"
    t.datetime "published_at"
    t.string   "author"
    t.text     "tweet"
    t.string   "image_url"
    t.string   "tweet_url"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "website_analytics", force: :cascade do |t|
    t.date     "date"
    t.integer  "visitors"
    t.integer  "pageviews"
    t.integer  "sessions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
