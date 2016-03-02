class Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :assessment
  belongs_to :strand

  validates :assessment, presence: true
  # TODO: can we validate that score is within the range of the assessment?
  validates :score, :inclusion => { :in => 0..8 }
  validates :strand, presence: true
  validates :user, presence: true

  scope :dropped, -> { where(drop: true) }
  scope :active, -> { where(drop: false) }
end
