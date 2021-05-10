# frozen_string_literal: true

module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def auth_as(user = nil)
    user ||= FactoryBot.create(:user)
    token = user.create_new_auth_token

    { 'access-token' => token['access-token'],
      'token-type' => token['token-type'],
      'client' => token['client'],
      'expiry' => token['expiry'],
      'uid' => token['uid'] }
  end
end
