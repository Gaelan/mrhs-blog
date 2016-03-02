after 'development:courses', 'development:tasks' do
  Assessment.create! section: Section.first,
                     tasks: [Task.first],
                     due_date: Time.current + 7.days
end
