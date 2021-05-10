# frozen_string_literal: true

Rails.application.routes.draw do
  namespace 'v1' do
    mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
    post 'auth/request', to: 'authorization#get_authorization'
  end
end
