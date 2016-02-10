json.array!(@tasks) do |task|
  json.extract! task, :id, :title, :body, :category, :time_required
  json.url task_url(task, format: :json)
end
