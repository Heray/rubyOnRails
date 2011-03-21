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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110321053411) do

  create_table "calendar_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "calendar_id"
    t.string   "permission"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "email_notif"
    t.integer  "popup_notif"
    t.string   "invite_notif"
    t.string   "change_notif"
    t.string   "cancel_notif"
    t.string   "reply_notif"
  end

  add_index "calendar_users", ["calendar_id"], :name => "calendar_id"
  add_index "calendar_users", ["user_id"], :name => "user_id"

  create_table "calendars", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "description"
    t.integer  "privacy"
    t.string   "location"
    t.string   "timezone"
    t.string   "country"
    t.integer  "email_notif"
    t.integer  "popup_notif"
    t.string   "invite_notif"
    t.string   "change_notif"
    t.string   "cancel_notif"
    t.string   "reply_notif"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.string   "permission"
    t.integer  "email_notif"
    t.integer  "popup_notif"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_users", ["event_id"], :name => "event_id"
  add_index "event_users", ["user_id"], :name => "user_id"

  create_table "events", :force => true do |t|
    t.string   "title",                          :null => false
    t.time     "start_time",                     :null => false
    t.time     "end_time",                       :null => false
    t.date     "start_date",                     :null => false
    t.date     "end_date",                       :null => false
    t.string   "location"
    t.text     "description"
    t.integer  "privacy"
    t.boolean  "all_day"
    t.boolean  "repeat",      :default => false
    t.string   "on_days"
    t.string   "on_months"
    t.string   "on_years"
    t.integer  "email_notif"
    t.integer  "popup_notif"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "calendar_id"
  end

  add_index "events", ["calendar_id"], :name => "calendar_id"

  create_table "friends", :force => true do |t|
    t.integer  "user_id",          :null => false
    t.integer  "friend_id"
    t.string   "friend_email"
    t.float    "relation"
    t.integer  "shared_calendars"
    t.integer  "shared_events"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friends", ["friend_id"], :name => "friend_id"
  add_index "friends", ["user_id"], :name => "user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.datetime "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
