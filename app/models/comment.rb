class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  has_many :comments, as: :commentable

  validates :user, presence: true
  validates :body, presence: true, length: { minimum: 16 }
end
