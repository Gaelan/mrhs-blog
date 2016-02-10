class Assessment < ActiveRecord::Base
  belongs_to :section
  has_many :assessment_tasks
  has_many :tasks, through: :assessment_tasks
end
