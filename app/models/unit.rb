class Unit < ActiveRecord::Base
  has_many :course_units
  has_many :courses, through: :course_units

  has_many :unit_tasks
  has_many :tasks, through: :unit_tasks

  validates :title, presence: true, length: { minimum: 4, maximum: 80 }
  # TODO: Config: max unit duration
  validates :duration, :inclusion => { :in => 1..180 }, allow_nil: true
end
