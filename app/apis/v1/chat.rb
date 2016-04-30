module V1
  class Chat < Grape::API
    include Default
    helpers SharedHelpers
      resource :chat, desc: "채팅 관련 API" do
        desc "채팅 트리거",{
          http_codes: {
              :'200' => "메시지 트리거링 성공",
              :'402' => "메시지 트리거링 실패"
          }, entity: Entities::ResponseFormat
        }
        params do
          requires :token, desc: "유저 토큰", type: String
          requires :channel, desc: "채널 이름", type: String
          requires :event_name, desc: "이벤트 이름", type: String
          requires :message, desc: "메시지 내용", type: String
        end
        post do
          @pusher = pusher
          @pusher.trigger(params[:channel], params[:event_name], {
                                                  message: params[:message]
                                              });

          _response($_success,"메시지 트리거링 성공",200)
        end
      end
    end
end