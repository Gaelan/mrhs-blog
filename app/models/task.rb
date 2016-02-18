class Task < ActiveRecord::Base
  has_many :assessment_tasks
  has_many :assessments, through: :assessment_tasks
  has_many :task_strands
  has_many :strands, through: :task_strands
end
