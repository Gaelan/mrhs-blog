# app/models/strand.rb
#
class Strand < ActiveRecord::Base
  belongs_to :objective

  has_many :task_strands
  has_many :tasks, through: :task_strands
  has_many :assessments, through: :tasks
  has_many :rubrics, as: :rubricable

  def to_s
    objective.group + number.to_s + ': ' + label
  end
end
