# app/models/assessment.rb
#
class Assessment < ActiveRecord::Base
  validates :section, presence: true
  validates :tasks, presence: true

  belongs_to :section

  has_many :assessment_tasks
  has_many :tasks, through: :assessment_tasks
  has_many :strands, through: :tasks

  # formative? et al methods appear as if by magic...
  enum category: %i( formative summative summative_final )
end
