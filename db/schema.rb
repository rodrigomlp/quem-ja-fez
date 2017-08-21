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

ActiveRecord::Schema.define(version: 20170821144936) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.datetime "start"
    t.datetime "end"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.text "review_title"
    t.text "review_content"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "undergraduate_id"
    t.integer "highschooler_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "resume_id"
    t.string "virtual_room"
    t.index ["resume_id"], name: "index_meetings_on_resume_id"
  end

  create_table "resumes", force: :cascade do |t|
    t.string "school_email"
    t.integer "relative_completion"
    t.text "academic_description"
    t.string "stance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "university_id"
    t.bigint "course_id"
    t.bigint "user_id"
    t.boolean "email_checked", default: false
    t.string "email_confirmation_token"
    t.index ["course_id"], name: "index_resumes_on_course_id"
    t.index ["university_id"], name: "index_resumes_on_university_id"
    t.index ["user_id"], name: "index_resumes_on_user_id"
  end

  create_table "universities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gender"
    t.date "birth_date"
    t.string "city"
    t.string "country"
    t.boolean "undergraduate", default: false
    t.text "personal_description"
    t.string "provider"
    t.string "uid"
    t.string "facebook_picture_url"
    t.string "first_name"
    t.string "last_name"
    t.string "token"
    t.datetime "token_expiry"
    t.string "photo"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "events", "users"
  add_foreign_key "meetings", "resumes"
  add_foreign_key "meetings", "users", column: "highschooler_id"
  add_foreign_key "meetings", "users", column: "undergraduate_id"
  add_foreign_key "resumes", "courses"
  add_foreign_key "resumes", "universities"
  add_foreign_key "resumes", "users"
end
