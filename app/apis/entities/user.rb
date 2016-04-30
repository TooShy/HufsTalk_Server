module Entities
  class User < Grape::Entity
    expose :id, documentation: {type: Integer, desc: "유저 ID", required: true}
    expose :email, documentation: {type: String, desc: "이메일", required: true}
    expose :name, documentation: {type: String, desc: "이름", required: true}
    expose :age, documentation: {type: Integer, desc: "나이", required: true}
    expose :gender, documentation: {type: :boolean, desc: "성별", required: true}
  end
end