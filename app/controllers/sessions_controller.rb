# frozen_string_literal: true

require 'httparty'
require 'json'

class SessionsController < ApplicationController
  include HTTParty

  def get_authorization
    url = "https://www.googleapis.com/oauth2/v3/userinfo?access_token=#{params['access_token']}"

    response = HTTParty.get(url)

    @user = User.create_user_for_google(response.parsed_response)
    @user.save

    tokens = @user.create_new_auth_token
    set_headers(tokens)

    render json: { message: 'Successfully signed in.' }, status: :created
  end

  private

  def set_headers(tokens)
    headers['access-token'] = (tokens['access-token']).to_s
    headers['client'] =  (tokens['client']).to_s
    headers['expiry'] =  (tokens['expiry']).to_s
    headers['id'] = @user.id
    headers['uid'] = @user.uid
    headers['email'] = @user.email
    headers['role'] = @user.role
    headers['token-type'] = (tokens['token-type']).to_s
  end

  def authorization_params
    params.permit(:access_token)
  end
end
