# frozen_string_literal: true

# TODO pass params by env vars
ActiveRecord::Base.establish_connection(adapter: "postgresql",
  encoding: "unicode",
  database: "slotted_counters",
  host: "localhost",
  port: 9339,
  username: "postgres")

ActiveRecord::Schema.define do
  create_table "slotted_counters", force: :cascade do |t|
    t.string "counter_name", null: false
    t.string "associated_record_type", null: false
    t.integer "associated_record_id", null: false
    t.integer "slot", null: false
    t.integer "count", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["associated_record_id", "associated_record_type", "counter_name", "slot"], name: "index_slotted_counters", unique: true
  end

  create_table "with_native_counter_articles", force: :cascade do |t|
    t.integer "comments_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "with_native_counter_comments", force: :cascade do |t|
    t.bigint "with_native_counter_article_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["with_native_counter_article_id"], name: "native_counter_article_id"
  end

  create_table "with_slotted_counter_articles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes_count", default: 0
  end

  create_table "with_slotted_counter_specific_articles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes_count", default: 0
  end

  create_table "with_slotted_counter_comments", force: :cascade do |t|
    t.bigint "with_slotted_counter_article_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["with_slotted_counter_article_id"], name: "slotted_counter_comments_article_id"
  end

  create_table "with_slotted_counter_likes", force: :cascade do |t|
    t.bigint "with_slotted_counter_article_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["with_slotted_counter_article_id"], name: "slotted_counter_likes_article_id"
  end

  add_foreign_key "with_native_counter_comments", "with_native_counter_articles"
  add_foreign_key "with_slotted_counter_comments", "with_slotted_counter_articles"
  add_foreign_key "with_slotted_counter_likes", "with_slotted_counter_articles"
end

ActiveRecord::Base.logger = Logger.new($stdout) if ENV["LOG"]