Rails.application.config.to_prepare do
  ::Rack::MiniProfiler.counter_method(HomeTeacherHelper, :posts_for_assessment)
  ::Rack::MiniProfiler.counter_method(HomeTeacherController, :get_students)
end
