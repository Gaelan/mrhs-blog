class Strand < ActiveRecord::Base
  belongs_to :objective
  has_many :task_strands
  has_many :tasks, through: :task_strands
end
