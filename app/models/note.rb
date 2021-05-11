# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :user
  has_one :weather_reading

  after_create do |note|
    WeatherChecker.call(note)
  end

  before_update do |note|
    if saved_change_to_city?
      note.weather_reading.destroy!
      WeatherChecker.call(note)
    end
  end

  validates_presence_of :city, :title, :content
end
