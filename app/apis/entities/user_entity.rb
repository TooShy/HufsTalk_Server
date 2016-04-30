module Entities
  class UserEntity < Grape::Entity
    expose :uid, documentation: {type: Integer, desc: "FACEBOOK UID", required: true}
    expose :email, documentation: {type: String, desc: "이메일", required: true}
    expose :gender, documentation: {type: :boolean, desc: "성별", required: true}
  end
end