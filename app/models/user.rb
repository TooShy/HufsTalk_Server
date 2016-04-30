require 'digest'

class User < ActiveRecord::Base
  has_one :session

  validates_uniqueness_of :uid, :email


  def self.login(uid)
    @user = User.find_by_uid(uid)
    if @user
      @token = Digest::MD5.hexdigest(SecureRandom.uuid.to_s)

      if @session = Session.find_by_user_id(@user.id)
        @session.token = @token
      else
        @session = Session.new(token: @token, user_id: @user.id)
      end

      @session.save
      @user.session = @session
      if @user.save
        [1, @user, @session]
      else
        [-1,"세션 생성중 오류가 발생하였습니다"]
      end

    else
      [-1,"해당 유저의 UID를 찾을 수 없습니다."]
    end
  end
end
