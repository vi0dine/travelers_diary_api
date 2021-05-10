# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:uid) { |n| Faker::Internet.email << n.to_s }
    sequence(:email) { |n| Faker::Internet.email << n.to_s }
    role { :user }
    encrypted_password { Faker::Internet.password }
    provider { 'google_oauth2' }

    trait :admin do
      role { :admin }
    end
  end
end
