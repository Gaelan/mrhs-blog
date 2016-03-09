t = User.create!(email: 'teacher@g.highlineschools.org', name: 'Teacher')

t.roles.create role: :teacher
