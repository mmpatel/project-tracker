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

ActiveRecord::Schema.define(version: 20141208130822) do

  create_table "audits", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "creator_id"
    t.integer  "issue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["issue_id"], name: "index_comments_on_issue_id"

  create_table "issues", force: true do |t|
    t.integer  "creator_id"
    t.string   "description"
    t.string   "title"
    t.string   "state"
    t.integer  "assigned_to"
    t.date     "completed_by"
    t.date     "started_on"
    t.string   "estimate"
    t.string   "issue_type"
    t.integer  "workflow_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "issues", ["project_id"], name: "index_issues_on_project_id"
  add_index "issues", ["workflow_id"], name: "index_issues_on_workflow_id"

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "access_level"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  add_index "teams", ["project_id"], name: "index_teams_on_project_id"
  add_index "teams", ["user_id"], name: "index_teams_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "admin",               default: false
    t.boolean  "blocked",             default: true
    t.boolean  "can_create_projects", default: false
    t.string   "state",               default: "init"
    t.string   "avatar_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.integer  "uid"
  end

  create_table "workflows", force: true do |t|
    t.string   "name"
    t.string   "tag"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workflows", ["project_id"], name: "index_workflows_on_project_id"

end
