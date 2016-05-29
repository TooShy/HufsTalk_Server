require 'pusher'
module SharedHelpers extend Grape::API::Helpers

  # helpers
  def _response(status,message,code,data = {})
    status 200
    {status: status, message: message, code: code, data: data}
  end

  def logger
    Grape::API.logger
  end

  def pusher
    client = Pusher::Client.new(
          app_id: '198407',
          key: 'f5ad826261aeb8068be6',
          secret: '65aeb65e5284061ec691',
          cluster: 'ap1',
          encrypted: true
      )
    client
  end

  def current_user
    session = Session.find_by_token(params[:token])
    if session
      @current_user = User.find(session.user_id)
      if @current_user.ban_count >= 3
        _response($_failed,"밴 된 계정입니다. 관리자에게 문의하세요",401)
      else
        yield
      end
    else
      _response($_failed,"유저를 찾을 수 없습니다",404)
    end
  end

end
