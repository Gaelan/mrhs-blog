class Section < ActiveRecord::Base
  belongs_to :course
  has_many :enrollments
  has_many :students, through: :enrollments, class_name: 'User'
end