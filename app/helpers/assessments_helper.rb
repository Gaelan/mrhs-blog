#
module AssessmentsHelper
  # Returns a MRHS standard assessment name for each standard/objective
  # assessed. The form is:
  #
  #   OBJ.Unit.Assessment#.ShortName -> B1.1.1.UP
  #
  # The overall name is limited to 24 characters.
  #
  def illuminate_assessment_name(assessment)
    assessment.strands.map do |strand|
      limit = 24  # Max characters in assignment name.
      sn = strand.objective.group + strand.number.to_s
      unit = 1    # TODO: use real unit numbers.
      f = assessment.formative? ? 'F' : ''
      num = Assessment.where(
        'section_id = ? AND due_date < ?',
        assessment.section_id, assessment.due_date
      ).count + 1
      illuminate_name = "#{sn}.#{unit}.#{f}#{num}."

      short = mogrify(assessment.tasks[0].title, limit - illuminate_name.length)

      illuminate_name + short
    end.join '\n'
  end

  # Returns an assessment description suitable for pasting into Illuminate.
  #
  # Illuminate does not respect any formatting in the description, so we try
  # to deliver only one paragraph of plain text along with the full assignment
  # name.
  #
  def illuminate_assessment_description(assessment)
    markdown assessment.tasks[0].body
  end

  # Shorten string:
  # - Always elminiate white space, then
  # - Truncate after a word, then
  # - Acronymize (elminate lower case letters)
  #
  def mogrify(str, nchars)
    if str.gsub!(/ */, '').length >= nchars
      str.gsub!(/[a-z]*/, '')
    end
    str
  end
end
