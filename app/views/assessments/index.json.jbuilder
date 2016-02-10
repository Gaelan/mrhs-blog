json.array!(@assessments) do |assessment|
  json.extract! assessment, :id, :assigned_date, :due_date, :value, :weight, :autoscore, :title, :category, :section_id
  json.url assessment_url(assessment, format: :json)
end
