class Comment < ActiveRecord::Base
  after_create :debug
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  has_many :comments, as: :commentable

  validates :user, presence: true

  def debug
    1+1
  end
end
