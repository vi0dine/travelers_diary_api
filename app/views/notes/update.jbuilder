# frozen_string_literal: true

json.note do
  json.id @note.id
  json.city @note.city
  json.title @note.title
  json.content @note.content
  json.weather do
    json.temp @note.weather_reading&.temperature
  end
  json.created_at @note.created_at
end
