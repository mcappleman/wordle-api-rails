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

ActiveRecord::Schema[8.0].define(version: 2025_02_17_024845) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "answers", force: :cascade do |t|
    t.string "word"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "board_cells", force: :cascade do |t|
    t.bigint "board_row_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "char", null: false
    t.string "color", null: false
    t.index ["board_row_id"], name: "index_board_cells_on_board_row_id"
  end

  create_table "board_rows", force: :cascade do |t|
    t.bigint "board_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_board_rows_on_board_id"
  end

  create_table "boards", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "wordle_id", null: false
    t.bigint "answer_id", null: false
    t.index ["answer_id"], name: "index_boards_on_answer_id"
    t.index ["wordle_id"], name: "index_boards_on_wordle_id"
  end

  create_table "guesses", force: :cascade do |t|
    t.string "word"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "wordle_id", null: false
    t.index ["wordle_id"], name: "index_guesses_on_wordle_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wordles", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "max_guesses"
    t.integer "num_of_boards"
    t.index ["user_id"], name: "index_wordles_on_user_id"
  end

  add_foreign_key "board_cells", "board_rows"
  add_foreign_key "board_rows", "boards"
  add_foreign_key "boards", "answers"
  add_foreign_key "boards", "wordles"
  add_foreign_key "guesses", "wordles"
  add_foreign_key "wordles", "users"
end
