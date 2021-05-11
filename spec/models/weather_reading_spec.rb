# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherReading, type: :model do
  subject { create(:weather_reading) }

  it { should validate_presence_of(:weather) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:temperature) }
  it { should validate_presence_of(:pressure) }
  it { should validate_presence_of(:humidity) }
  it { should validate_presence_of(:clouds) }
  it { should validate_presence_of(:wind_speed) }

  it { should validate_numericality_of(:temperature) }
  it { should validate_numericality_of(:pressure) }
  it { should validate_numericality_of(:humidity) }
  it { should validate_numericality_of(:clouds) }
  it { should validate_numericality_of(:wind_speed) }

  it { should belong_to(:note) }
end
