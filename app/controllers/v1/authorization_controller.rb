module V1
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # See https://github.com/omniauth/omniauth/wiki/FAQ#rails-session-is-clobbered-after-callback-on-developer-strategy
    # skip_before_action :verify_authenticity_token, only: :google

    def google_oauth2
      @user = User.from_omniauth(params[:auth])
    end

    def failure
      render json: {}, status: :unprocessable_entity
    end

    private

    def omniauth_params
      params.permit(:auth)
    end
  end
end