json.array!(@posts) do |post|
  json.extract! post, :id, :user_id, :parent_id, :published, :level, :title, :body
  json.url post_url(post, format: :json)
end
