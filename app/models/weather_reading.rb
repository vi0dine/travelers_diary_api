# frozen_string_literal: true

class WeatherReading < ApplicationRecord
  belongs_to :note

  validates_presence_of :weather, :description, :temperature, :humidity, :pressure, :wind_speed, :clouds
  validates_numericality_of :temperature, :humidity, :pressure, :wind_speed, :clouds
end
