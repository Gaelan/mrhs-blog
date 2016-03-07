#
module HomeStudentHelper
  # Return a color string that can be used to set a CSS class to provide
  # visual feedback on progress. Argument is an Assessment.
  #
  # TODO: other sanity checks, nil bodies, no photos, small photos.
  # TODO: be explicit about what you find in sanity checks. Hover?
  def annunciator(a)
    if Score.where(user_id: @user.id, assessment_id: a.id).any?
      # Assessment has been scored.
      'blue'
    elsif Post.where(user_id: @user.id, assessment_id: a.id, published: true).any?
      # There is at least one published post against this assessment.
      'green'
    elsif Post.where(user_id: @user.id, assessment_id: a.id).any?
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

  # Determine whether we should edit or create a post (assessment).
  #
  def new_or_edit(user, assessment)
    if Post.where(user_id: user.id, assessment_id: assessment.id).any?
      # TODO: show if post is published or scored?
      post_or_posts = Post.where(user_id: user.id, assessment_id: assessment.id)
      if post_or_posts.count == 1
        edit_user_post_path(user_id: user.id, id: post_or_posts[0].id)
      else
        # TODO: need to do something better if there are more than one post.
        '/'   # Return to student home.
      end
    else
      new_user_post_path(user_id: user.id, assessment_id: assessment.id)
    end
  end
end
