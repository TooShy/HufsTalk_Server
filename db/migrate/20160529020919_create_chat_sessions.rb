class CreateChatSessions < ActiveRecord::Migration
  def change
    create_table :chat_sessions do |t|
      t.string :channel_name
      t.string :filter_string, default: ''
      t.timestamps null: false
    end
  end
end
