module HomeTeacherHelper
  # Expects: uid - a User id
  #          aids - an array of Assessment ids
  # Returns: an array of assessment info hashes
  def assessment_overview(uid, aids)
    posts = Post.where(user: uid, assessment: aids)
    status = aids.map do |a|
      # binding.pry
      {
        assessment: a,
        status: assessment_status(a, posts)
      }
    end
    # binding.pry
    format_status(status)
  end

  def assessment_status(aid, posts)
    if posts.empty? then 'not-started'
    else
      post = posts.where(assessment: aid)
      if post.length == 0
        'not-started'
      elsif post.length == 1
        p = post[0]
        if p.published
          'submitted'
        else
          'started'
        end
      else
        'not-started'
      end
    end
  end

  def format_status(as)
    status = as.map do |s|
      '<button class="status '"#{s[:status]}"'"> &nbsp; </button>'
    end.join
    #binding.pry
    status.html_safe
  end
end
