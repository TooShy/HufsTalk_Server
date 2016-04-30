module Entities
  class UserResponse < Entities::ResponseFormat
    expose :data, using: Entities::User, documentation: {type:"User",desc: "User 모델"}
  end
end