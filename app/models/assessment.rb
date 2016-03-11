# app/models/assessment.rb
#
class Assessment < ActiveRecord::Base
  validates :section, presence: true
  validates :tasks, presence: true

  belongs_to :section

  has_many :assessment_tasks
  has_many :tasks, through: :assessment_tasks
  has_many :scores
  has_many :strands, through: :tasks

  # formative? et al methods appear as if by magic...
  enum category: %i( formative summative summative_final )

  # rubric?
  def rubric?
    true # XXX - make it so, check if a rubric is defined for this object.
  end

  # rubric - return the rubric for this assessment
  #
  # XXX: this shouldn't be here - rubrics can exist on many levels...
  def rubric
    strand_ids = strands.map &:id
    rubrics = []
    rubric_candidates = Rubric
                        .where(
                          strand_id: strand_ids,
                          rubricable: [[@task], nil]
                        )
    strand_ids.each do |sid|
      strand_rubrics = rubric_candidates.select { |r| r.strand_id == sid }
      bands = strand_rubrics.map &:band
      bands.uniq.each do |band|
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
  end

  def to_s
    title
  end

  # scoreable - return an array of Post that are ready to be scored (marked
  #             published if the due date is not passed, or that are not empty
  #             if the due date has passed).
  #
  #             If passed 'autoscore: true' then a score will be created for
  #             missing assessments and assessments that are empty.
  #
  # TODO: do better checking on autoscore.
  # TODO: pass autoscore as a block that returns a score.
  # TODO: default autoscore methods (return 0 if body is empty & no images).
  #
  def scoreable(autoscore = false)
    Post.where(assessment: id)
  end

  # updated - assessment has changed since most recent Score.
  #
  def updatated
  end
end
