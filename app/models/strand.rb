# app/models/strand.rb
#
class Strand < ActiveRecord::Base
  belongs_to :objective

  has_many :task_strands
  has_many :tasks, through: :task_strands
  has_many :assessments, through: :tasks
  has_many :rubrics, as: :rubricable

  def to_s(format: :long)
    case :format
    when :short
      suffix = ''
    when :long
      suffix = ': ' + label
    else
      suffix = 'strand.to_s called with unknown format'
    end
    objective.group + number.to_s + suffix
  end
end
