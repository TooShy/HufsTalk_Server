class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :uid, unique: true, limit: 8
      # t.string :email, unique: true
      t.boolean :gender # 0: male, 1: female
      t.belongs_to :session
      t.timestamps null: false
    end
  end
end
