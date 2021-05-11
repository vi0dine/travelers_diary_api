# frozen_string_literal: true

FactoryBot.define do
  factory :weather_reading do
    weather { Faker::Quote.singular_siegler }
    description { Faker::Quote.matz }
    temperature { Faker::Base.rand_in_range(0, 50) }
    pressure { Faker::Base.rand_in_range(0, 1100) }
    humidity { Faker::Base.rand_in_range(0, 100) }
    clouds { Faker::Base.rand_in_range(0, 100) }
    wind_speed { Faker::Base.rand_in_range(0, 80) }
    note
  end
end
