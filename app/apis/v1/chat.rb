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
          requires :message, desc: "메시지 내용", type: String
        end
        post do
          @pusher = pusher
          @pusher.trigger(params[:channel], 'chat', {
                                                  message: params[:message]
                                              });

          _response($_success,"메시지 트리거링 성공",200)
        end

        desc "채팅 채널 입장/퇴장",{
            http_codes: {
                :'200' => "트리거링 성공",
                :'402' => "트리거링 실패"
            }, entity: Entities::ResponseFormat
        }
        params do
          requires :token, desc: "유저 토큰", type: String
          requires :channel, desc: "채널 이름", type: String
          requires :is_in, desc: "입장/퇴장 플래그", type: Boolean
        end
        post 'inout'do
          @pusher = pusher
          if params[:entered]
            @pusher.trigger(params[:channel], 'in', {
                message: params[:token]
            });
          else
            @pusher.trigger(params[:channel], 'out', {
                message: params[:token]
            });
          end

          _response($_success,"트리거링 성공",200)
        end

        ## Current Working Pointer: TODO - 대기큐및매칭알고리즘구현
      end
    end
end