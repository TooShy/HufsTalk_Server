class ChatSession < ActiveRecord::Base
  has_many :users

end
