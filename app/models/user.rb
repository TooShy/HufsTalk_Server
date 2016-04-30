class User < ActiveRecord::Base
  has_one :session

  def login(user)
    @user = User.find(user)
    if @user
      [1,@user]
    else
      [-1,"해당 유저의 UID를 찾을 수 없습니다."]
    end
  end
end
