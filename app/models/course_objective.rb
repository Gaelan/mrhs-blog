class CourseObjective < ActiveRecord::Base
  belongs_to :course
  belongs_to :objective

  validates :course, presence: true
  validates :objective, presence: true
end
