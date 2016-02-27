#
class Task < ActiveRecord::Base
  # Tasks can be associated with a Unit.
  has_many :unit_tasks
  has_many :tasks, through: :unit_tasks # TODO: shouldn't this be has_many :units?

  # Students are asked to complete a Task through an Assessment.
  has_many :assessment_tasks
  has_many :assessments, through: :assessment_tasks

  # The basis for evaluating a Task is through an Objective Strand.
  has_many :task_strands
  has_many :strands, through: :task_strands

  # Rubrics are attached to Tasks and Strands, each Rubric
  # instance represents one scoring band.
  has_many :rubrics, as: :rubricable
end
