# Post model definition
#
class Post < ActiveRecord::Base
  belongs_to :user
  has_many :images
  accepts_nested_attributes_for :images,
                                allow_destroy: true,
                                reject_if: :all_blank
  has_many :comments, as: :commentable
  belongs_to :assessment
  # XXX - the line below wasn't returning the right Scores, it wasn't using
  #       :user_id to limit the results returned, so we were seeing all scores
  #       against the assessment. The method below seems closer...
  # has_many :scores, through: :assessment
  has_many :strands, through: :assessment

  validates :assessment_id, presence: true

  scope :published,   -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }

  def images?
    images.count
  end

  def rubric
    # XXX - what should we do here? Return empty array if assessment is nil?
    assessment && assessment.rubric
  end

  #
  def scores
    Score.where(user_id: user_id,
                assessment_id: assessment.id,
                # strand_id: assessment.strands[0].id
               )
  end
end
