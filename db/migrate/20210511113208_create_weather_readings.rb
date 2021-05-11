# frozen_string_literal: true

class CreateWeatherReadings < ActiveRecord::Migration[6.1]
  def change
    create_table :weather_readings do |t|
      t.string :weather
      t.string :description
      t.integer :temperature
      t.integer :pressure
      t.integer :humidity
      t.integer :clouds
      t.integer :wind_speed
      t.belongs_to :note
      t.timestamps
    end
  end
end
