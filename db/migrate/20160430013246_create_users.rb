class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :uid, unique: true, limit: 8
      # t.string :email, unique: true
      t.boolean :gender # false: male, true: female
      t.integer :ban_count, default: 0
      t.boolean :is_banned, default: false
      t.boolean :prefer_gender, default: true
      t.string :filter_string, default:''
      t.belongs_to :chat_session
      t.timestamps null: false
    end
  end
end
