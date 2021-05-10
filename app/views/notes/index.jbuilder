# frozen_string_literal: true

json.notes do
  json.array! @notes do |note|
    json.id note.id
    json.city note.city
    json.title note.title
    json.content note.content
    json.created_at note.created_at
  end
end

json.pagination do
  json.current         @notes.current_page
  json.previous        @notes.prev_page
  json.next            @notes.next_page
  json.limit           @notes.limit_value
  json.total_pages     @notes.total_pages
  json.total_count     @notes.total_count
end
