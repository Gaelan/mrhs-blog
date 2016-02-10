# Post model definition
#
class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent, class_name: Post, inverse_of: :children
  has_many :children, class_name: Post, inverse_of: :parent
  has_many :images
  accepts_nested_attributes_for :images,
                                allow_destroy: true,
                                reject_if: :all_blank
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }

  # Note on levels:
  # 0 - Prompt
  # 1 - Normal Post
  # 2 - Comment
  # 3 - Comment on Comment
  # 4...
end
