module V1
  class Users < Grape::API
    include Default
    helpers SharedHelpers

    resource :users, desc: "유저 관련 API" do
      desc "회원 가입",{
          http_codes: {
              :'200' => "가입 성공",
              :'402' => "가입 실패"
          }, entity: Entities::ResponseFormat
      }

      params do
        requires :uid, desc: "FACEBOOK 유저 고유 ID", type: Integer
        # 이메일 제외
        # requires :email, desc: "FACEBOOK 유저 이메일", type: String
        requires :gender, desc: "성별(true: 남성, false: 여성)", type: Boolean
      end

      post :join do
          new_user = User.new(params.to_hash)
          if new_user.save
            _response $_success, "가입 성공", 200
          else
            _response $_failed, "가입 실패", 402
          end
      end


      desc "로그인",{
          http_codes: {
          :'200' => "로그인 성공",
          :'404' => "UID 없음"
      },
          entity: Entities::LoginSuccessResponse
      }
      params do
        requires :uid, desc: "FACEBOOK 유저 UID", type: Integer
      end
      post :login do
        result = User.login(params[:uid])
        if result[0] == 1
          _response $_success,"로그인 성공",200,{user:result[1], session: result[2]}
        else
          _response $_failed,result[1],404
        end
      end

      desc "금지어 설정",{
          http_codes: {
              :'200' => "금지어 설정 성공",
              :'404' => "유저를 찾을 수 없음",
              :'401' => "밴 당한 유저"
          },
          entity: Entities::ResponseFormat
      }
      params do
        requires :token, desc: "세션 토큰", type: String
        requires :filter_string, desc: "필터 문자열(split_by: ',')", type:String
      end
      post :set_filter do
        current_user do
          @current_user.filter_string = params[:filter_string].gsub(' ','')
          if @current_user.save
            _response $_success,"금지어 설정 성공",200,{user:@current_user}
          end
        end
      end
    end
  end
end

