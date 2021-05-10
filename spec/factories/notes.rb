# frozen_string_literal: true

FactoryBot.define do
  factory :note do
    city { Faker::Address.city }
    title { Faker::Lorem.question }
    content { Faker::Lorem.paragraphs(number: 3) }
    user
  end
end
