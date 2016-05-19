class CreateTopicsUsers < ActiveRecord::Migration
  def change
    create_table :topics_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :topic, index: true
    end
  end
end
