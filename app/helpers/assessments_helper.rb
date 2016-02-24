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

      illuminate_name + short
    end.join('<br>').html_safe
  end

  # Returns an assessment description suitable for pasting into Illuminate.
  #
  # Illuminate does not respect any formatting in the description, so we try
  # to deliver only one paragraph of plain text along with the full assignment
  # name.
  #
  def illuminate_assessment_description(assessment)
    # TODO: fix ordering - 1) markdown, 2) de-HTML, 3) truncate
    # TODO: dynamic link
    # TODO: translation
    # TODO: configurable see_full message
    # binding.pry
    see_full = 'See the full description on the class blog: http://mrhs-photo-blog.heroku.com.'
    body = markdown (truncate assessment.tasks[0].body,
                       length: 400, omission: '',
                       separator: "\r\n\r\n")
    "#{assessment.tasks[0].title}: #{body} #{see_full}"
  end

  # Shorten string:
  # - Always elminiate white space, then
  # - TODO: Truncate after a word, then
  # - Acronymize (elminate lower case letters)
  #
  def mogrify(str, nchars)
    newstr = str.gsub(/ */, '')
    if newstr.length >= nchars
      newstr.gsub!(/[a-z]*/, '')
    end
    newstr
>>>>>>> Stashed changes
  end
end
