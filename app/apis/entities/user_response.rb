module Entities
  class UserResponse < Entities::ResponseFormat
    expose :data, using: Entities::UserEntity, documentation: {type:"User",desc: "User 모델"}
  end
end