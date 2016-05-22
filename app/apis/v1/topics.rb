module V1
  class  Topics < Grape::API
    include Default
    helpers SharedHelpers

    resource :topics, desc: "토픽 관련 API" do

      desc "현재 전체 토픽 리스트 가져오기", {
          http_codes: {
              :'200' => "응답 완료",
              :'401' => "찾을 수 없는 세션 토큰",
              :'404' => "토픽 리스트가 없습니다"
          }
      }
      get :total_topic_list do
        if Topic.all.empty?
          _response $_failed, "토픽리스트가 존재하지 않습니다", 404
        else
          _response $_success, "전체 토픽 조회 완료", 200, {topic_list: Topic.all}
        end
      end

      desc "유저 토픽 리스트 조회", {
          http_codes: {
              :'200' => "응답 완료",
              :'401' => "찾을 수 없는 세션 토큰",
              :'404' => "유저 토픽 리스트가 존재하지 않습니다."
          }
      }
      params do
        requires :token, desc: "유저 세션 토큰", type: String
      end
      get :user_topic_list do
        current_user do
          if @current_user.topics.empty?
            _response $_failed,"유저 토픽 리스트가 존재하지 않습니다",401
          else
            _response $_success, "유저 토픽 조회 완료", 200, {topic_list: @current_user.topics}
          end

        end
      end

      desc "유저 토픽 리스트 세팅하기", {
          http_codes: {
              :'200' => "응답 완료",
              :'401' => "찾을 수 없는 세션 토큰"
          }
      }
      params do
        requires :token, desc: "유저 세션 토큰", type: String
        requires :topic_list, desc: "Topic Array String", type: String
      end
      post :set do
        current_user do
          topic_list = params[:topic_list].gsub(' ','').split(',').uniq

          @current_user.topics = Topic.add(topic_list)
          if @current_user.save
            _response $_success,"토픽 세팅 성공",200,{topic_list: @current_user.topics}
          else
            _response $_failed,"토픽 세팅 실패",500
          end
        end
      end
    end
  end
end

