class Task < ActiveRecord::Base
  has_many :assessment_tasks
  has_many :assessments, through: :assessment_tasks
end
