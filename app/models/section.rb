#
class Section < ActiveRecord::Base
  belongs_to :course
  has_many :assessments
  has_many :enrollments
  has_many :objectives, through: :course
  has_many :strands, through: :objectives
  has_many :students, through: :enrollments, class_name: 'User'
end
