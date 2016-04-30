module Entities
  class LoginData < Grape::Entity
    expose :user, using: Entities::UserEntity, as: :user, documentation: {type:"User",desc: "유저 모델"}
    expose :session, using: Entities::Session, as: :session, documentation: {type:"Session",desc: "세션 모델"}
  end
end