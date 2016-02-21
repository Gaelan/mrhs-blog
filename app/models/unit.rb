class Unit < ActiveRecord::Base
  has_many :course_units
  has_many :courses, through: :course_units
end
