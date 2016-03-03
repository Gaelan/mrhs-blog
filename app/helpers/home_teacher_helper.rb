module HomeTeacherHelper
  # Expects: uid - a User id
  #          aids - an array of Assessment ids
  #
  # Returns: an array of assessment info hashes
  # - aid: Assessment.id
  # - a_title: Assessment.title
  # - post: array of hashes { pid: Post.id, title: Post.title, status: CSS class names [] }
  # - scores: array of hashes { stand: Strand.id, rubric: Rubric.id, score: Score.id, value: Score.score }

  def assessment_overview(uid, aids)
    posts = Post.where(user: uid, assessment: aids)
    post_info = aids.map do |a|
      # binding.pry
      {
        uid: uid,
        aid: a,
        a_title: Assessment.find(a).title,
        posts: posts_for_assessment(a, posts),
        scores: []
      }
    end
    # binding.pry
    format_status(post_info)
  end

  def posts_for_assessment(aid, posts)
    post_or_posts = posts.where(assessment: aid)
    case post_or_posts.count
    when 0
      [{ pid: nil, title: nil, status: nil }]
    when 1
      # binding.pry
      [{
        pid: post_or_posts[0].id,
        title: post_or_posts[0].title,
        status: assessment_status(aid, post_or_posts[0])
      }]
    else
      # XXX: figure out how to handle multiple posts in annunicators.
      #      Could do a decending date by mod time, to show the most recent by
      #      default and figure out a way to show a select list if clicked or
      #      some similar scheme.
      post_or_posts.map do |p|
        {pid: p.id, title: p.title, status: assessment_status(aid, p) }
      end
      # binding.pry
    end
  end

  def assessment_status(aid, post)
    # binding.pry
    status = []
    if post.published
      status << 'published'
      if Score.where(user: post.user, assessment: aid).count > 0
        status << 'scored'
      end
    end
    if post.body.blank?
      status << 'empty'
    end

    # binding.pry
    status.join(' ')
  end

  def last_seen(uid)
    last = User.find(uid).active_today? ? 'today' : 'long-time-ago'
    "<span class=\"#{last} status\"></span>".html_safe
  end

  def format_status(pi)
    annunicator_style = ' status'
    css = ''
    href = ''
    title = ''
    status = pi.map do |info|
      if info[:posts][0][:pid] == nil
        href = '#'
        css = 'not-started' + annunicator_style
      else
        css = info[:posts][0][:status] + annunicator_style
        href = user_post_path(info[:uid], info[:posts][0][:pid])
      end
      title = "#{info[:a_title]}\n#{info[:posts][0][:title]}".html_safe
      # binding.pry
      "<a href=\"#{href}\" title=\"#{title}\" class=\"#{css}\">&nbsp;</a>"
    end.join.html_safe
    status
  end
end
