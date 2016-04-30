module Entities
  class CreditResponse < ResponseFormat
    expose :data, using: Entities::Credit, as: :data, documentation: {type:"Credit",desc: "크레딧 데이터"}
  end
end