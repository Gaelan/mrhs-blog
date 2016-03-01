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

  # rubric?
  def rubric?
    true  # XXX - make it so, check if a rubric is defined for this object.
  end

  # rubric - return the rubric for this assessment
  def rubric
    strand_ids = strands.map &:id
    rubrics = []
    candidates = Rubric.where(strand_id: strand_ids)
    strand_ids.each do |sid|
      strand_rubrics = candidates.select { |r| r.strand_id == sid }
      bands = strand_rubrics.map &:band
      bands.each do |band|
        band_max = strand_rubrics.select { |r| r.band == band }.max_by &:level
        rubrics += [band_max]
      end
    end
    hack = Rubric.where(id: (rubrics.map &:id))
                 .order(
                 strand_id: :asc, # XXX - Hack, should be...
                 # strand.objective.group: :asc,
                 # strand.number: :asc,
                 band: :asc)
    # binding.pry
    # hack
  end
end
