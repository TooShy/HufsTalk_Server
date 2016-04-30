module Entities
  class ResponseFormat < Grape::Entity
    expose :status, documentation: {type: String,desc:"응답 성공/실패", required: true}
    expose :message, documentation: {type: String,desc:"응답 메시지",required: true}
    expose :code,  documentation: {type: Integer,desc:"응답 코드", required: true}
  end
end