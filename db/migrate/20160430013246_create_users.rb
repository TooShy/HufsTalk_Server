class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :uid
      t.string :email
      t.boolean :gender # 0: male, 1: female
      t.belongs_to :session
      t.timestamps null: false
    end
  end
end
