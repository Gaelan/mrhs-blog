# Seed Course and Section tables in development environment.
#
# bin/rails db:seed

Course.create title: 'Photography I', short_title: 'P1'

Section.create session: 1, period: 1, course_id: 1, name: 'S1P1-P1'

# Student IDs are really User IDs, #1 is the teacher.
Enrollment.create student_id: 2, section_id: 1
Enrollment.create student_id: 3, section_id: 1
Enrollment.create student_id: 4, section_id: 1
