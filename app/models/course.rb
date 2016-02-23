# Course model definition
#
class Course < ActiveRecord::Base
  validates :title, presence: true
  validates :short_title, presence: true

  has_many :course_units
  has_many :units, through: :course_units

  has_many :sections

  accepts_nested_attributes_for :sections,
                                allow_destroy: true,
                                reject_if: :all_blank
end
