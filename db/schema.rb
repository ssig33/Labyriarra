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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111003045855) do

  create_table "channel", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "channel", ["name"], :name => "name", :unique => true

  create_table "log", :force => true do |t|
    t.integer  "channel_id"
    t.integer  "nick_id"
    t.text     "log"
    t.integer  "is_privmsg", :limit => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "log", ["channel_id"], :name => "channel_id"
  add_index "log", ["created_at", "channel_id"], :name => "created_at_2"
  add_index "log", ["created_at"], :name => "created_at"
  add_index "log", ["nick_id"], :name => "nick_id"

  create_table "nick", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nick", ["name"], :name => "name", :unique => true

  create_table "unreads", :force => true do |t|
    t.integer  "channel_id"
    t.integer  "log_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "unreads", ["channel_id"], :name => "index_unreads_on_channel_id", :unique => true

end
