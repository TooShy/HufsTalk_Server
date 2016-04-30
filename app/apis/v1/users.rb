module V1
  class Users < Grape::API
    include Default
    helpers SharedHelpers

    resource :users, desc: "유저 관련 API" do
      desc "회원 가입",{
          http_codes: {
              :'200' => "가입 성공",
              :'402' => "가입 실패"
          },
          entity: Entities::JoinFailResponse
      }
      params do
        requires :name, desc: "유저 이름", type: String
        requires :email, desc: "이메일", type: String
        requires :password, desc: "패스워드", type: String
        requires :gender, desc: "성별", type: Boolean
        requires :age, desc:"나이", type: Integer
        requires :role, desc:"유저 구분 : 0: none, 1: student, 2: professor, 3: doctor, 4: patient, 5: vip", type: Integer
      end
      post :join do
          new_user = User.new(params.to_hash)
          if new_user.save
            _response $_success, "가입 성공", 200
          else
            _response $_failed, "가입 실패", 402, new_user.errors
          end
      end

      desc "로그인",{
          http_codes: {
          :'200' => "로그인 성공",
          :'401' => "패스워드 틀림",
          :'404' => "아이디 없음",
      },
          entity: Entities::LoginSuccessResponse
      }
      params do
        requires :email, desc: "이메일", type: String
        requires :password, desc: "패스워드", type: String
      end
      post :login do
        result = User.login(params.to_hash)
        if result[0] == 1
          _response($_success,"로그인 성공",200,result[1])
        else
          _response($_failed,result[1],result[2])
        end
      end

      desc "유저 정보 가져오기",{
          http_codes: {
              :'200' => "성공",
              :'404' => "유저를 찾을 수 없습니다."
          },
          entity: Entities::UserResponse
      }
      params do
        requires :token, desc: "로그인 토큰", type: String
      end
      get do
        current_user do
          _response($_success,"성공",200,@user_attr)
        end
      end
    end

  end
end

