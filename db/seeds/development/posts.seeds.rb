after 'development:students', 'development:assessments' do
  User.find_by_email('ts1@g.highlineschools.org').posts.create!(
    title: 'Post for Assessment',
    assessment: Assessment.first,
    body: 'A body.'
  ) # XXX Way to seed in an image?
end
