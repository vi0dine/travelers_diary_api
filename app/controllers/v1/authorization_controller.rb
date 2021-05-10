# frozen_string_literal: true

require 'httparty'
require 'json'

module V1
  class AuthorizationController < ApplicationController
    include HTTParty

    def get_authorization
      url = "https://www.googleapis.com/oauth2/v3/tokeninfo?access_token=#{params['access_token']}"
      response = HTTParty.get(url)

      pp response.parsed_response

      @user = User.create_user_for_google(response.parsed_response)
      tokens = @user.create_new_auth_token
      @user.save
      set_headers(tokens)
      render json: { status: 'Signed in successfully.' }, status: :created
    end

    private

    def set_headers(tokens)
      headers['id'] = @user.id
      headers['email'] = @user.email
      headers['access-token'] = (tokens['access-token']).to_s
      headers['role'] = @user.role
    end

    def authorization_params
      params.permit(:access_token)
    end
  end
end
