# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit

  rescue_from Pundit::NotAuthorizedError do |error|
    render json: { message: error.message.capitalize }, status: :forbidden
  end
end
