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

ActiveRecord::Schema.define(version: 20141109142854) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bands", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], :name => "index_bands_on_name", :unique => true
  end

  create_table "assets", force: true do |t|
    t.string   "file",       null: false
    t.string   "name",       null: false
    t.integer  "band_id",    null: false
    t.integer  "asset_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["asset_id"], :name => "fk__assets_asset_id"
    t.index ["asset_id"], :name => "index_assets_on_asset_id"
    t.index ["band_id"], :name => "fk__assets_band_id"
    t.index ["band_id"], :name => "index_assets_on_band_id"
    t.foreign_key ["asset_id"], "assets", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_assets_asset_id"
    t.foreign_key ["band_id"], "bands", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_assets_band_id"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "provider"
    t.string   "uid",                    default: "", null: false
    t.text     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], :name => "index_users_on_email"
    t.index ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
    t.index ["uid"], :name => "index_users_on_uid", :unique => true
  end

  create_table "band_users", force: true do |t|
    t.integer  "band_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["band_id"], :name => "fk__band_users_band_id"
    t.index ["user_id"], :name => "fk__band_users_user_id"
    t.foreign_key ["band_id"], "bands", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_band_users_band_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_band_users_user_id"
  end

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], :name => "index_tags_on_name", :unique => true
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], :name => "taggings_idx", :unique => true
    t.index ["tag_id"], :name => "fk__taggings_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.foreign_key ["tag_id"], "tags", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_taggings_tag_id"
  end

end
