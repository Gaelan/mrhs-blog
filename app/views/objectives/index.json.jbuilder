json.array!(@objectives) do |objective|
  json.extract! objective, :id, :group, :name, :description
  json.url objective_url(objective, format: :json)
end
