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

ActiveRecord::Schema.define(version: 20150409174813) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "is_active"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.text     "short_description"
    t.text     "you_learn"
    t.text     "you_build"
    t.string   "slug"
    t.string   "teaser"
  end

  create_table "lesson_users", force: :cascade do |t|
    t.integer  "lesson_id"
    t.integer  "user_id"
    t.boolean  "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "lesson_users", ["lesson_id"], name: "index_lesson_users_on_lesson_id", using: :btree
  add_index "lesson_users", ["user_id"], name: "index_lesson_users_on_user_id", using: :btree

  create_table "lessons", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.string   "description"
    t.integer  "section_id"
    t.boolean  "is_project",  default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "url"
    t.text     "content"
    t.integer  "course_id"
  end

  add_index "lessons", ["section_id"], name: "index_lessons_on_section_id", using: :btree

  create_table "lessons_users_tables", force: :cascade do |t|
    t.integer "lesson_id"
    t.integer "user_id"
    t.boolean "completed"
  end

  create_table "sections", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.integer  "course_id"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "sections", ["course_id"], name: "index_sections_on_course_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
