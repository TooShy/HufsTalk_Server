class User < ActiveRecord::Base
  has_one :session

  def login(uid)
    @user = User.find_by_uid(uid)
    if @user
      [1,@user]
    else
      [-1,"해당 유저의 UID를 찾을 수 없습니다."]
    end
  end
end
