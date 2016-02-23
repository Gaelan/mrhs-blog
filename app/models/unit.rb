class Unit < ActiveRecord::Base
  has_many :course_units
  has_many :courses, through: :course_units

  has_many :unit_tasks
  has_many :tasks, through: :unit_tasks
end
