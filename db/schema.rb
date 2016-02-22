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

ActiveRecord::Schema.define(version: 20160222025658) do

  create_table "assessment_tasks", force: :cascade do |t|
    t.integer  "assessment_id"
    t.integer  "task_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["assessment_id"], name: "index_assessment_tasks_on_assessment_id"
    t.index ["task_id"], name: "index_assessment_tasks_on_task_id"
  end

  create_table "assessments", force: :cascade do |t|
    t.datetime "assigned_date"
    t.datetime "due_date"
    t.integer  "value"
    t.integer  "weight"
    t.integer  "autoscore"
    t.string   "title"
    t.integer  "category"
    t.integer  "section_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["section_id"], name: "index_assessments_on_section_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.integer  "user_id"
    t.text     "body"
    t.boolean  "private"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "course_units", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_units_on_course_id"
    t.index ["unit_id"], name: "index_course_units_on_unit_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string   "title"
    t.string   "short_title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "section_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_enrollments_on_section_id"
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "images", force: :cascade do |t|
    t.string   "caption"
    t.string   "src"
    t.string   "maker"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "post_id"
    t.index ["post_id"], name: "index_images_on_post_id"
  end

  create_table "objectives", force: :cascade do |t|
    t.string   "group"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "published"
    t.integer  "level"
    t.string   "title"
    t.string   "body"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "assessment_id"
    t.index ["assessment_id"], name: "index_posts_on_assessment_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role"
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string   "name"
    t.integer  "year"
    t.integer  "session"
    t.integer  "period"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_sections_on_course_id"
  end

  create_table "strands", force: :cascade do |t|
    t.integer  "number"
    t.text     "description"
    t.integer  "objective_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "label"
    t.index ["objective_id"], name: "index_strands_on_objective_id"
  end

  create_table "task_strands", force: :cascade do |t|
    t.integer  "task_id"
    t.integer  "strand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["strand_id"], name: "index_task_strands_on_strand_id"
    t.index ["task_id"], name: "index_task_strands_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "category"
    t.integer  "time_required"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "units", force: :cascade do |t|
    t.string   "title"
    t.text     "soi"
    t.integer  "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "last_active_time"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.boolean  "up",         null: false
    t.integer  "user_id",    null: false
    t.integer  "post_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_votes_on_post_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

end
