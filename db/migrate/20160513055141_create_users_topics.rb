class CreateUsersTopics < ActiveRecord::Migration
  def change
    create_table :users_topics do |t|
      t.belongs_to :user, index: true
      t.belongs_to :topic, index: true
    end
  end
end
