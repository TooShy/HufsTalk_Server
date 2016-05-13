class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :topic_name, unique: true, index: true
      t.timestamps null: false
    end
  end
end
