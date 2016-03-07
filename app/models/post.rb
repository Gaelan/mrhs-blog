# Post model definition
#
class Post < ActiveRecord::Base
  belongs_to :user
  has_many :images
  accepts_nested_attributes_for :images,
                                allow_destroy: true,
                                reject_if: :all_blank
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }

  has_many :comments, as: :commentable
  belongs_to :assessment
  has_many :scores, through: :assessment

  def rubric
    # XXX - what should we do here? Return empty array if assessment is nil?
    assessment && assessment.rubric
  end

  #
  def scores
    # Score.where(user_id: user_id,
    #             assessment_id: assessment.id,
    #             strand_id: assessment.strands[0].id)
  end

  def strands
  end
end
