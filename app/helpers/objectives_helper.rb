#
module ObjectivesHelper
  def strand_label(strand)
    "#{strand.objective.group}#{strand.number}: #{strand.lable}"
  end
end
