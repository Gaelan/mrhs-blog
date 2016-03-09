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
      {
        uid: uid,
        aid: a,
        a_title: Assessment.find(a).title,
        posts: posts_for_assessment(a, posts),
        scores: []
      }
    end
    format_status(post_info)
  end

  def posts_for_assessment(aid, posts)
    post_or_posts = posts.where(assessment: aid)
    case post_or_posts.count
    when 0
      [{ pid: nil, title: nil, status: nil }]
    when 1
      [{
        pid: post_or_posts[0].id,
        title: (sanitize post_or_posts[0].title),
        status: assessment_status(aid, post_or_posts[0])
      }]
    else
      # XXX: figure out how to handle multiple posts in annunicators.
      #      Could do a decending date by mod time, to show the most recent by
      #      default and figure out a way to show a select list if clicked or
      #      some similar scheme.
      post_or_posts.map do |p|
        {
          pid: p.id,
          title: (sanitize p.title),
          status: assessment_status(aid, p)
        }
      end
    end
  end

  def assessment_status(aid, post)
    # TODO: better computation of post status (add need-help?).
    # TODO: also look for images.
    # TODO: requirement checking.
    # TODO: start on base of not-started or not-started/started switch?
    status = []
    if post.published
      status << 'published'
      if Score.where(user: post.user, assessment: aid).count > 0
        status << 'scored'
      end
    else
      status << 'unpublished'
      unless post.body.blank? && post.title.blank?
        status << 'started'
      else
        status << 'not-started'
      end
    end
    if post.body.blank?
      status << 'empty'
    end
    status.join(' ')
  end

  def last_seen(uid)
    last = User.find(uid).active_today? ? 'today' : 'long-time-ago'
    "<span class=\"#{last} status\"></span>".html_safe
  end

  def unclassified_posts(uid)
    how_many = Post.where(user: uid, assessment: nil).count
    if how_many > 0
      css = 'red-border'
    end
    "<span class=\"status unclassified-posts #{css}\"><span class=\"count\">#{how_many}</span></span>".html_safe
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
      "<a href=\"#{href}\" title=\"#{title}\" class=\"#{css}\">&nbsp;</a>"
    end.join.html_safe
    status
  end
end
