class Session < ActiveRecord::Base
  has_one :user
end
