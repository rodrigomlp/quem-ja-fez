json.array! @events do |event|
  date_format = '%Y-%m-%dT%H:%M:%S'
  json.id event.id
  json.title event.title
  json.start event.start
  json.end event.end
  json.color event.color unless event.color.blank?
end
