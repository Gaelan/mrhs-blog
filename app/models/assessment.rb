#
class Assessment < ActiveRecord::Base
  validates :section, presence: true
  validates :tasks, presence: true

  belongs_to :section
  has_many :assessment_tasks
  has_many :tasks, through: :assessment_tasks
end
