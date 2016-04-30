module V1
  class Base < Grape::API
    version 'v1', using: :header, vendor: 'Hufstalk', format: :json, cascade: true
    mount V1::Chat
    mount V1::Users
  end
end
