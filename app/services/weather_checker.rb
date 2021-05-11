# frozen_string_literal: true

class WeatherChecker < ApplicationService
  attr_reader :note

  def initialize(note)
    @note = note
  end

  def call
    url = "https://api.openweathermap.org/data/2.5/weather?q=#{I18n.transliterate(@note.city)}&appid=#{ENV['OPENWEATHER_KEY']}"
    response = HTTParty.get(url)
    data = response.parsed_response

    WeatherReading.create!({
                             weather: data['weather'].first['main'],
                             description: data['weather'].first['description'],
                             temperature: k_to_c(data['main']['temp'].to_f),
                             humidity: data['main']['humidity'].to_i,
                             pressure: data['main']['pressure'].to_i,
                             wind_speed: data['wind']['speed'].to_i,
                             clouds: data['clouds']['all'].to_i,
                             note: @note
                           })
  rescue StandardError => e
    warn "Can't check weather." # Some better logic here needed...
  end

  private

  def k_to_c(temp_in_k)
    (temp_in_k - 273.15).round
  end
end
