class Score < ActiveRecord::Base
  belongs_to :assessment
  belongs_to :post, touch: true
  belongs_to :strand
  belongs_to :user

  # TODO: drop should be false on create (but maybe should be settable at create
  # time). Where should the default be set.

  validates :assessment, presence: true
  validates :post, presence: true
  # TODO: can we validate that score is within the range of the assessment?
  validates :score, inclusion: { in: 0..8 }, allow_nil: true
  validates :strand, presence: true
  validates :user, presence: true

  scope :dropped, -> { where(drop: true) }
  scope :active, -> { where(drop: false) }

  def self.for(opts)
    create_with(drop: false).find_or_initialize_by opts
  end
end
