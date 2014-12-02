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

ActiveRecord::Schema.define(version: 20141202124017) do

  create_table "exports", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "export_file_name"
    t.string   "export_content_type"
    t.integer  "export_file_size"
    t.datetime "export_updated_at"
  end

  create_table "order_items", force: true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "qty"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.string   "payment_type"
    t.string   "receive_name"
    t.string   "receive_address"
    t.integer  "total"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "payment_status"
    t.datetime "paid_at"
    t.string   "paypal_status"
    t.string   "paypal_transaction_id"
    t.text     "paypal_params"
    t.string   "paypal_payment_id"
    t.string   "paypal_state"
    t.datetime "paypal_create_time"
    t.datetime "paypal_update_time"
    t.string   "paypal_approval_url"
    t.string   "paypal_execute_url"
    t.text     "paypal_error"
    t.string   "paypal_payer_id"
    t.datetime "paypal_return_at"
  end

  add_index "orders", ["paypal_payment_id"], name: "index_orders_on_paypal_payment_id"

  create_table "products", force: true do |t|
    t.string   "name"
    t.integer  "qty",        default: 0
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
