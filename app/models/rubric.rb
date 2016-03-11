class Rubric < ActiveRecord::Base
  belongs_to :strand
  belongs_to :rubricable, polymorphic: true

  validates :band, presence: true
  validates :criterion, presence: true
  validates :level, presence: true
  validates :task_id, value: nil # Should be unused.

  enum level: %i( authority school subject unit project task )

  def verify_level
    # If a Rubric is created in the context of a :level (e.g., a Task),
    # :rubricable will be set to the object. If the user changes :level in the
    # course of the edit, set rubricable to nil.
    unless rubricable_type && level.casecmp(rubricable_type) == 0
      self.rubricable = nil
    end
  end
end
