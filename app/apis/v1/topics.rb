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

      desc "유저 토픽 리스트 조회", {
          http_codes: {
              :'200' => "응답 완료",
              :'401' => "찾을 수 없는 세션 토큰",
              :'404' => "유저 토픽 리스트가 존재하지 않습니다."
          }
      }

      desc "유저 토픽 리스트 추가하기", {
          http_codes: {
              :'200' => "응답 완료",
              :'401' => "찾을 수 없는 세션 토큰"
          }
      }
      params do
        requires :token, desc: "유저 세션 토큰", type: String
        requires :topic_list, desc: "Topic List Array", type: Array[String]
      end
      post :add do
        if current_user
          ##### Working Checkpoint #####
          {uid: @current_user.uid, topic_list: params[:topic_list]}
        end
      end

      desc "유저 토픽 수정하기", {
          http_codes: {
              :'200' => "토픽 세팅 완료",
              :'401' => "찾을 수 없는 세션 토큰"
          }
      }
      params do
        requires :token, desc: "유저 세션 토큰", type: String
        requires :topic_list, desc: "Topic List Array", type: Array[String]
      end
      put :update do
        if current_user

        end
      end

    desc "특정 유저 토픽 삭제하기"

    end
  end
end

