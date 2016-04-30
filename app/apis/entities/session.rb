module Entities
  class Session < Grape::Entity
    expose :token, documentation: {type: String, desc: "세션 토큰 스트링", required: true}
  end
end