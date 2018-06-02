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

ActiveRecord::Schema.define(version: 20160706010909) do

  create_table "english_translations", force: :cascade do |t|
    t.text "value", null: false
  end

  create_table "listen_complete_test_results", force: :cascade do |t|
    t.integer "tr_id"
    t.integer "lc_id"
    t.text    "answer"
  end

  create_table "listen_complete_tests", force: :cascade do |t|
    t.integer "t_id"
    t.integer "lc_id"
  end

  create_table "listen_completes", force: :cascade do |t|
    t.text    "story",          null: false
    t.integer "page",           null: false
    t.text    "passage",        null: false
    t.integer "sf_id"
    t.integer "playback_start", null: false
    t.integer "playback_end",   null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "single_choice_test_results", force: :cascade do |t|
    t.integer "tr_id"
    t.integer "sc_id"
    t.integer "answer", null: false
  end

  create_table "single_choice_tests", force: :cascade do |t|
    t.integer "t_id"
    t.integer "sc_id"
  end

  create_table "single_choices", force: :cascade do |t|
    t.text    "title",   null: false
    t.text    "choice0", null: false
    t.text    "choice1", null: false
    t.text    "choice2", null: false
    t.text    "choice3", null: false
    t.integer "answer",  null: false
  end

  create_table "sort_test_results", force: :cascade do |t|
    t.integer "tr_id"
    t.integer "st_id"
    t.text    "answer"
  end

  create_table "sort_tests", force: :cascade do |t|
    t.integer "t_id"
    t.integer "st_id"
    t.text    "sortees", null: false
  end

  create_table "sorts", force: :cascade do |t|
    t.text "title",   null: false
    t.text "content", null: false
  end

  add_index "sorts", ["title"], name: "sqlite_autoindex_sorts_1", unique: true

  create_table "sound_files", force: :cascade do |t|
    t.text     "name",        null: false
    t.text     "location",    null: false
    t.datetime "uploaded_at", null: false
  end

  create_table "test_results", force: :cascade do |t|
    t.text     "name",     null: false
    t.integer  "t_id"
    t.datetime "start_at", null: false
    t.datetime "end_at",   null: false
  end

  add_index "test_results", ["name"], name: "sqlite_autoindex_test_results_1", unique: true

  create_table "tests", force: :cascade do |t|
    t.text "name", null: false
  end

  add_index "tests", ["name"], name: "sqlite_autoindex_tests_1", unique: true

  create_table "word_english_translations", force: :cascade do |t|
    t.integer "w_id"
    t.integer "et_id"
  end

  create_table "words", force: :cascade do |t|
    t.text "name",                null: false
    t.text "english_translation", null: false
  end

  add_index "words", ["name"], name: "sqlite_autoindex_words_1", unique: true

end
