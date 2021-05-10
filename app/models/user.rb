# frozen_string_literal: true

class User < ApplicationRecord
  extend Devise::Models
  include DeviseTokenAuth::Concerns::User

  before_save -> { skip_confirmation! }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  enum role: %i[user admin]

  validates :uid,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false, scope: :provider }

  validates_presence_of :provider, :role

  validates_inclusion_of :role, in: %w[user admin]

  def self.create_user_for_google(data)
    where(email: data['email']).first_or_initialize.tap do |user|
      user.email = data['email']
      user.uid = data['sub']
      user.password = SecureRandom.alphanumeric(8)
      user.password_confirmation = user.password
      user.save!
    end
  end
end
