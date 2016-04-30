module Entities
  class LoginSuccessResponse < ResponseFormat
    expose :login_data, using: Entities::LoginData, as: :data, documentation: {type:"LoginData",desc: "유저 및 토큰"}
  end
end