json.array!(@scores) do |score|
  json.extract! score, :id, :score, :drop, :note, :user_id, :assessment_id, :strand_id
  json.url score_url(score, format: :json)
end
