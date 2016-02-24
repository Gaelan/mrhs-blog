#
class Assessment < ActiveRecord::Base
  validates :section, presence: true
  validates :tasks, presence: true

  belongs_to :section
  has_many :assessment_tasks
  has_many :tasks, through: :assessment_tasks
  has_many :strands, through: :tasks

  def formative?
    # TODO: allow formative assessments, need to add field to db.
    false
  end
end
