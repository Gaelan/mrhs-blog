json.array!(@units) do |unit|
  json.extract! unit, :id, :title, :soi, :duration
  json.url unit_url(unit, format: :json)
end
