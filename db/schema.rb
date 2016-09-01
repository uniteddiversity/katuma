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

ActiveRecord::Schema.define(version: 20160901094107) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", force: :cascade do |t|
    t.integer  "group_id",                      null: false
    t.integer  "invited_by_id",                 null: false
    t.string   "email",                         null: false
    t.string   "token",                         null: false
    t.datetime "sent_at"
    t.boolean  "accepted",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invitations", ["token"], name: "index_invitations_on_token", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "group_id",   null: false
    t.integer  "role",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["user_id", "group_id"], name: "index_memberships_on_user_id_and_group_id", unique: true, using: :btree

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                         null: false
    t.string   "uid",                          null: false
    t.string   "secret",                       null: false
    t.text     "redirect_uri",                 null: false
    t.string   "scopes",       default: "",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "superapp",     default: false
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "order_lines", force: :cascade do |t|
    t.integer  "unit",       default: 1, null: false
    t.integer  "price",                  null: false
    t.integer  "quantity",               null: false
    t.integer  "order_id",               null: false
    t.integer  "product_id",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_lines", ["order_id"], name: "index_order_lines_on_order_id", using: :btree
  add_index "order_lines", ["product_id"], name: "index_order_lines_on_product_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "group_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["group_id"], name: "index_orders_on_group_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "producers", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "email",      null: false
    t.text     "address",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "producers_memberships", force: :cascade do |t|
    t.integer  "producer_id", null: false
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "role",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "producers_memberships", ["group_id"], name: "producers_memberships_group_id_idx", unique: true, where: "(group_id IS NOT NULL)", using: :btree
  add_index "producers_memberships", ["producer_id"], name: "producers_memberships_producer_id_idx", unique: true, where: "(producer_id IS NOT NULL)", using: :btree
  add_index "producers_memberships", ["user_id"], name: "producers_memberships_user_id_idx", unique: true, where: "(user_id IS NOT NULL)", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",        null: false
    t.integer  "price",       null: false
    t.integer  "unit",        null: false
    t.integer  "producer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["producer_id"], name: "index_products_on_producer_id", using: :btree

  create_table "signups", force: :cascade do |t|
    t.string   "email",      null: false
    t.string   "token",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suppliers", force: :cascade do |t|
    t.integer  "group_id",    null: false
    t.integer  "producer_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "suppliers", ["group_id", "producer_id"], name: "index_suppliers_on_group_id_and_producer_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "producers_memberships", "groups", name: "producers_memberships_group_id_fkey"
  add_foreign_key "producers_memberships", "producers", name: "producers_memberships_producer_id_fkey"
  add_foreign_key "producers_memberships", "users", name: "producers_memberships_user_id_fkey"
  add_foreign_key "suppliers", "groups"
  add_foreign_key "suppliers", "producers"
end
