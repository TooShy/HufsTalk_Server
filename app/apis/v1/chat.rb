module V1
  class Chat < Grape::API
    include Default
    helpers SharedHelpers


      resource :chat, desc: "채팅 관련 API" do
        desc "채팅 트리거",{
          http_codes: {
              :'200' => "메시지 트리거링 성공",
              :'404' => "세션 토큰을 찾을 수 없습니다",
              :'402' => "금지어 입력",
              :'401' => "밴 당한 유저"
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
            filter_string = @current_user.chat_session.filter_string.split(',')
            logger.info "asdfasdfasdfasdfsdf"
	    filter_string.each do |s|
              if params[:message].include? s
                @current_user.ban_count = @current_user.ban_count + 1
                @current_user.save
                @pusher.trigger(params[:channel], 'ban', {
                    token: params[:token],
	  	    filter_string: filter_string
                });
                return _response($_failed,"금지어 입력" ,402)
              end
            end
            @pusher.trigger(params[:channel], 'chat', {
                                                message: params[:message],
                                                token: params[:token],
						chat_session: @current_user.chat_session
                                            });

            _response($_success,"메시지 트리거링 성공",200)
          end
        end

        desc "채팅 채널 입장/퇴장",{
            http_codes: {
                :'200' => "트리거링 성공",
                :'404' => "세션 토큰을 찾을 수 없습니다",
                :'402' => "트리거링 실패",
                :'401' => "밴 당한 유저"
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
              :'200' => "매칭 요청 성공",
              :'201' => "대기큐 진입",
              :'404' => "세션 토큰을 찾을 수 없습니다",
              :'401' => "밴 당한 유저"
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
