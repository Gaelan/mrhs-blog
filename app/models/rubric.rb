class Rubric < ActiveRecord::Base
  belongs_to :strand
  belongs_to :rubricable, polymorphic: true

  validates :band, presence: true
  validates :criterion, presence: true
  validates :level, presence: true
  validates :task_id, value: nil

  enum level: %i( authority school subject unit project task )
end
