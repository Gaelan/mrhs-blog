#
module HomeStudentHelper
  # Return a color string that can be used to set a CSS class to provide
  # visual feedback on progress.
  def annunciator(a)
    if Post.where(user_id: @user.id, assessment_id: a.id, published: true).count
      # There is at least one published post against this assessment.
      'green'
    elsif Post.where(user_id: @user.id, assessment_id: a.id).count
      # There is at last one unpublished post aginst this assessment.
      if a.due_date > Time.now
        'orange'
      else
        'red'
      end
    else
      # Nothing yet.
      'red'
    end
  end
end
