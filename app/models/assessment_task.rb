class AssessmentTask < ActiveRecord::Base
  belongs_to :assessment
  belongs_to :task
end
