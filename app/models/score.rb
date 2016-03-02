class Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :assessment
  belongs_to :strand
end
