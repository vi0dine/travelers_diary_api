# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  include DeviseTokenAuth::Concerns::User

  enum role: %i[user admin]

  validates :uid,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false, scope: :provider }

  validates_presence_of :provider, :encrypted_password, :role

  validates_inclusion_of :role, in: %w[user admin]

  def self.create_user_for_google(data)
    where(email: data['email']).first_or_initialize.tap do |user|
      user.provider = 'google_oauth2'
      user.uid = data['email']
      user.email = data['email']
      user.role = :user
      user.password = Devise.friendly_token[0, 20]
      user.password_confirmation = user.password
      user.save!
    end
  end
end
