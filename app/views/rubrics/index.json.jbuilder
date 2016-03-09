json.array!(@rubrics) do |rubric|
  json.extract! rubric, :id, :level, :band, :criterion, :strand_id
  json.url rubric_url(rubric, format: :json)
end
