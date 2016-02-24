#
module AssessmentsHelper
  # Generate the MRHS standard assessment name for each standard/objective
  # assessed. The form is:
  #
  #   OBJ.Unit.Assessment#.ShortName -> B1.1.1.UP
  #
  # The short name is the first letter of each word in the Task name.
  def illuminate_assessment_name(assessment)
    assessment.strands.map do |strand|
      sn = strand.objective.group + strand.number.to_s
      unit = ''
      f = assessment.formative? ? 'F' : ''
      num = Assessment.where(section_id: assessment.section_id).count
      short = assessment.tasks[0].title.gsub(/[ a-z]*/, '')

      "#{sn}.#{unit}.#{f}#{num}.#{short}"
    end.join '\n'
  end
end
