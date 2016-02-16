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

  acts_as_commontable
  acts_as_votable
end
