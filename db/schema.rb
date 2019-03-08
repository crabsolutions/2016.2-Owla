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

ActiveRecord::Schema.define(version: 20161114115521) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id"
    t.text     "content"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "member_id"
    t.boolean  "anonymous",               default: false
    t.boolean  "moderated",               default: false
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.index ["cached_votes_down"], name: "index_answers_on_cached_votes_down", using: :btree
    t.index ["cached_votes_score"], name: "index_answers_on_cached_votes_score", using: :btree
    t.index ["cached_votes_total"], name: "index_answers_on_cached_votes_total", using: :btree
    t.index ["cached_votes_up"], name: "index_answers_on_cached_votes_up", using: :btree
    t.index ["cached_weighted_average"], name: "index_answers_on_cached_weighted_average", using: :btree
    t.index ["cached_weighted_score"], name: "index_answers_on_cached_weighted_score", using: :btree
    t.index ["cached_weighted_total"], name: "index_answers_on_cached_weighted_total", using: :btree
    t.index ["member_id"], name: "index_answers_on_member_id", using: :btree
    t.index ["question_id"], name: "index_answers_on_question_id", using: :btree
  end

  create_table "members", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.string   "alias"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "password_digest"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["email"], name: "index_members_on_email", unique: true, using: :btree
  end

  create_table "members_reports", id: false, force: :cascade do |t|
    t.integer "report_id"
    t.integer "member_id"
    t.index ["member_id"], name: "index_members_reports_on_member_id", using: :btree
    t.index ["report_id"], name: "index_members_reports_on_report_id", using: :btree
  end

  create_table "members_rooms", id: false, force: :cascade do |t|
    t.integer "member_id"
    t.integer "room_id"
    t.index ["member_id"], name: "index_members_rooms_on_member_id", using: :btree
    t.index ["room_id"], name: "index_members_rooms_on_room_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.text     "message"
    t.boolean  "read",        default: false
    t.integer  "receiver_id"
    t.integer  "sender_id"
    t.string   "link"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "topic_id"
    t.string   "content"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "member_id"
    t.boolean  "anonymous",               default: false
    t.boolean  "moderated",               default: false
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "slide_id"
    t.index ["cached_votes_down"], name: "index_questions_on_cached_votes_down", using: :btree
    t.index ["cached_votes_score"], name: "index_questions_on_cached_votes_score", using: :btree
    t.index ["cached_votes_total"], name: "index_questions_on_cached_votes_total", using: :btree
    t.index ["cached_votes_up"], name: "index_questions_on_cached_votes_up", using: :btree
    t.index ["cached_weighted_average"], name: "index_questions_on_cached_weighted_average", using: :btree
    t.index ["cached_weighted_score"], name: "index_questions_on_cached_weighted_score", using: :btree
    t.index ["cached_weighted_total"], name: "index_questions_on_cached_weighted_total", using: :btree
    t.index ["member_id"], name: "index_questions_on_member_id", using: :btree
    t.index ["topic_id"], name: "index_questions_on_topic_id", using: :btree
  end

  create_table "questions_tags", id: false, force: :cascade do |t|
    t.integer "question_id"
    t.integer "tag_id"
    t.index ["question_id"], name: "index_questions_tags_on_question_id", using: :btree
    t.index ["tag_id"], name: "index_questions_tags_on_tag_id", using: :btree
  end

  create_table "reports", force: :cascade do |t|
    t.text     "explanation"
    t.integer  "moderator_id"
    t.integer  "reported_id"
    t.integer  "answer_id"
    t.integer  "question_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["answer_id"], name: "index_reports_on_answer_id", using: :btree
    t.index ["moderator_id"], name: "index_reports_on_moderator_id", using: :btree
    t.index ["question_id"], name: "index_reports_on_question_id", using: :btree
    t.index ["reported_id"], name: "index_reports_on_reported_id", using: :btree
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "description"
    t.integer  "owner_id"
    t.text     "black_list"
  end

  create_table "tags", force: :cascade do |t|
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "member_id"
    t.string   "color"
    t.index ["member_id"], name: "index_tags_on_member_id", using: :btree
  end

  create_table "topics", force: :cascade do |t|
    t.integer  "room_id"
    t.string   "name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.text     "description"
    t.string   "slide_file_name"
    t.string   "slide_content_type"
    t.integer  "slide_file_size"
    t.datetime "slide_updated_at"
    t.index ["room_id"], name: "index_topics_on_room_id", using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.string   "votable_type"
    t.integer  "votable_id"
    t.string   "voter_type"
    t.integer  "voter_id"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree
  end

  add_foreign_key "answers", "members"
  add_foreign_key "questions", "members"
  add_foreign_key "tags", "members"
end
