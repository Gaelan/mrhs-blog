class TaskStrand < ActiveRecord::Base
  belongs_to :task
  belongs_to :strand
end
