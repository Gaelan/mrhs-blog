class Enrollment < ActiveRecord::Base
  belongs_to :section
  belongs_to :student, class_name: 'User'

  validates :section, presence: true
  validates :student, presence: true
end
