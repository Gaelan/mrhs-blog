class Objective < ActiveRecord::Base
  has_many :strands
  accepts_nested_attributes_for :strands,
                                allow_destroy: true,
                                reject_if: :all_blank
end
