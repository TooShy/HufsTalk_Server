module Entities
  class Credit < Grape::Entity
    expose :id, documentation: {type: Integer, desc: '크레딧 ID'}
    expose :wallet_id, documentation: {type: Integer, desc: '지갑 ID'}
    expose :one_time_pay_limit, documentation: {type: Float, desc:'단일 결제 한도', required: true}
    expose :age_limit, documentation:{type:Integer, desc:'나이 한도', required: true}
    expose :balance, documentation:{type:Float, desc:'잔여 한도', required: true}
    expose :status, documentation: {type: :boolean, desc: '0: 사용 불가, 1: 사용 가능', required: true}
  end

end