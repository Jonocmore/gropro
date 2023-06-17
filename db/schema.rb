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

ActiveRecord::Schema[7.0].define(version: 2023_06_10_140459) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "forums", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_forums_on_user_id"
  end

  create_table "garden_plants", force: :cascade do |t|
    t.bigint "garden_id", null: false
    t.bigint "plant_id", null: false
    t.bigint "user_id", null: false
    t.string "comment"
    t.string "planting_date"
    t.string "expected_harvest_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["garden_id"], name: "index_garden_plants_on_garden_id"
    t.index ["plant_id"], name: "index_garden_plants_on_plant_id"
    t.index ["user_id"], name: "index_garden_plants_on_user_id"
  end

  create_table "gardens", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.string "date_planted"
    t.string "location"
    t.integer "sunlight"
    t.integer "size"
    t.boolean "outside"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_gardens_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.bigint "forum_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["forum_id"], name: "index_messages_on_forum_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "plants", force: :cascade do |t|
    t.string "plant_image"
    t.string "plant_name"
    t.string "crop_rotation_group"
    t.string "soil"
    t.string "position"
    t.string "frost_tolerant"
    t.string "feeding"
    t.string "spacing_single_plant"
    t.string "spacing_rows"
    t.string "sow_and_plant"
    t.string "notes"
    t.string "harvesting"
    t.string "water_schedule"
    t.string "location"
    t.string "how_to"
    t.integer "sunlight"
    t.integer "size"
    t.string "lifecycle"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recommendations", force: :cascade do |t|
    t.bigint "plant_id", null: false
    t.string "text"
    t.string "trigger_conditions"
    t.bigint "garden_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["garden_id"], name: "index_recommendations_on_garden_id"
    t.index ["plant_id"], name: "index_recommendations_on_plant_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "title"
    t.string "text"
    t.string "author"
    t.string "date"
    t.string "file_type"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_resources", force: :cascade do |t|
    t.boolean "is_favorite"
    t.bigint "user_id", null: false
    t.bigint "resource_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_id"], name: "index_user_resources_on_resource_id"
    t.index ["user_id"], name: "index_user_resources_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "forums", "users"
  add_foreign_key "garden_plants", "gardens"
  add_foreign_key "garden_plants", "plants"
  add_foreign_key "garden_plants", "users"
  add_foreign_key "gardens", "users"
  add_foreign_key "messages", "forums"
  add_foreign_key "messages", "users"
  add_foreign_key "recommendations", "gardens"
  add_foreign_key "recommendations", "plants"
  add_foreign_key "user_resources", "resources"
  add_foreign_key "user_resources", "users"
end
