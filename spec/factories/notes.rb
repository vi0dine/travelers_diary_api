# frozen_string_literal: true

FactoryBot.define do
  factory :note do
    city { Faker::Address.city }
    title { Faker::Lorem.question }
    content { Faker::Quote.fortune_cookie }
    user
  end
end
