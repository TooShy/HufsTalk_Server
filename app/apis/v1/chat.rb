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
          current_user do
            @pusher = pusher
            @pusher.trigger(params[:channel], 'chat', {
                                                message: params[:message],
                                                token: params[:token]
                                            });

            _response($_success,"메시지 트리거링 성공",200)
          end
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
          current_user do
            @pusher = pusher
            if params[:entered]
              @pusher.trigger(params[:channel], 'in', {
                                                  token: params[:token]
                                              });
            else
              @pusher.trigger(params[:channel], 'out', {
                                                  token: params[:token]
                                              });
            end
            _response($_success,"트리거링 성공",200)
          end

        end

        desc "유저 매칭 요청",{
                              http_codes: {
                                  :'200' => "매칭 요청 성공"
                              }, entity: Entities::ResponseFormat
                          }
        params do
          requires :token, desc: "유저 토큰", type: String
        end
        get 'match' do
          current_user do
            matching_queue = MatchingQueue.instance
            if matching_queue.match(@current_user)
              _response($_success,"매칭 성공",200)
            else
              _response($_success,"대기큐 진입",201)
            end
          end
        end
      end
    end
end