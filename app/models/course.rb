# Course model definition
#
class Course < ActiveRecord::Base
  has_many :sections
  validates :title, presence: true
  validates :short_title, presence: true

  accepts_nested_attributes_for :sections,
                                allow_destroy: true,
                                reject_if: :all_blank
end
