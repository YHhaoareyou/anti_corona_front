# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_06_121545) do

  create_table "demands", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "post_id"
    t.integer "cloth_mask"
    t.integer "medical_mask"
    t.integer "n95_mask"
    t.integer "hand_sanitizer"
    t.integer "bleach_solution"
    t.integer "tissue_paper"
    t.integer "toilet_paper"
    t.integer "alcohol_wet_wipe"
    t.string "other"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "followed_posts_references", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "post_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.boolean "open_status", default: true
    t.integer "user_id"
    t.string "exchange_method", limit: 10
    t.string "preferred_date_time"
    t.string "preferred_place"
    t.string "email", limit: 100
    t.text "other_sns_urls"
    t.string "phone", limit: 20
    t.string "region", limit: 100
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supplies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "post_id"
    t.integer "cloth_mask"
    t.integer "medical_mask"
    t.integer "n95_mask"
    t.integer "hand_sanitizer"
    t.integer "bleach_solution"
    t.integer "tissue_paper"
    t.integer "toilet_paper"
    t.integer "alcohol_wet_wipe"
    t.string "other"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", limit: 200, default: "", null: false, collation: "utf8mb4_general_ci"
    t.string "encrypted_password", default: "", null: false, collation: "utf8mb4_general_ci"
    t.string "reset_password_token", limit: 200, collation: "utf8mb4_general_ci"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
