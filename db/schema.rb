# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

<<<<<<< HEAD
ActiveRecord::Schema[8.0].define(version: 2025_01_24_095041) do
=======
ActiveRecord::Schema[8.0].define(version: 2025_01_26_172811) do
>>>>>>> c8b23a8 (create task Application feature and cancan gem setup)
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "applications", force: :cascade do |t|
<<<<<<< HEAD
    t.bigint "user_id"
    t.bigint "task_id"
    t.string "stage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_applications_on_task_id"
    t.index ["user_id"], name: "index_applications_on_user_id"
=======
    t.bigint "task_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "worker_id", null: false
    t.index ["task_id"], name: "index_applications_on_task_id"
    t.index ["worker_id"], name: "index_applications_on_worker_id"
>>>>>>> c8b23a8 (create task Application feature and cancan gem setup)
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end


  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "task_id"
    t.string "message"
    t.integer "status"
    t.integer "notifications"
    t.datetime "sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_notifications_on_task_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.text "bio"
    t.string "contact_info"
    t.string "address"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "duration"
    t.decimal "salary"
    t.string "location"
    t.time "sift_hours"
    t.integer "sift"
    t.string "company"
    t.string "description"
    t.integer "status"
    t.integer "number_of_position"
    t.bigint "category_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_tasks_on_category_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"

    t.string "company"
    t.integer "status"
    t.integer "number_of_position"
    t.string "description"
    t.string "sift_hours"
    t.string "sift"
    t.string "job_mode"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "contractor_id", null: false
    t.integer "applications_count"
    t.index ["category_id"], name: "index_tasks_on_category_id"
    t.index ["contractor_id"], name: "index_tasks_on_contractor_id"
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
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "applications", "users", column: "worker_id"
  add_foreign_key "profiles", "users"
  add_foreign_key "tasks", "users", column: "contractor_id"
end
