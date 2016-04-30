class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :token
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
