# Seed students in the User and Role tables in development environment.
#
# bin/rails db:seed

User.create name: 'Test Student One',
            email: 'ts1@g.highlineschools.org',
            sign_in_count: 1,
            current_sign_in_at: Time.now,
            last_sign_in_at: (Time.now - 3.days),
            last_active_time: Time.now

Role.create user_id: 2, role: :student

User.create name: 'Test Student Two',
            email: 'ts2@g.highlineschools.org',
            sign_in_count: 2,
            current_sign_in_at: Time.now - 1.day,
            last_sign_in_at: Time.now - 2.days

Role.create user_id: 3, role: :student

User.create name: 'Test Student Three',
            email: 'ts3@g.highlineschools.org',
            sign_in_count: 1,
            current_sign_in_at: Time.now - 30.minutes,
            last_sign_in_at: nil,
            last_active_time: Time.now - 3.minutes

Role.create user_id: 4, role: :student

User.create name: 'Test Student Four',
            email: 'ts4@g.highlineschools.org',
            sign_in_count: 2,
            current_sign_in_at: nil,
            last_sign_in_at: nil

Role.create user_id: 5, role: :student
