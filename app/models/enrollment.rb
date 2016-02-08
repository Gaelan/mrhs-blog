class Enrollment < ActiveRecord::Base
  belongs_to :section
  belongs_to :user
end
