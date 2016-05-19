class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :uid, unique: true, limit: 8
      # t.string :email, unique: true
      t.boolean :gender # false: male, true: female
      t.integer :ban_count, default: 0
      t.boolean :is_banned
      t.boolean :prefer_gender, default: true
      t.belongs_to :session
      t.timestamps null: false
    end
  end
end
