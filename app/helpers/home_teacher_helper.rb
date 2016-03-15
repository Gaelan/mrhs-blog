module HomeTeacherHelper
  # Expects: uid - a User id
  #          aids - an array of Assessment ids
  #
  # Returns: an array of assessment info hashes
  # - aid: Assessment.id
  # - a_title: Assessment.title
  # - post: array of hashes { pid: Post.id, title: Post.title, status: CSS class names [] }
  # - scores: array of Score hashes

  def assessment_overview(uid, aids)
    posts = Post.where(user: uid, assessment: aids)
    post_info = aids.map do |a|
      {
        uid: uid,
        aid: a,
        a_title: Assessment.find(a).title,
        posts: posts_for_assessment(a, posts),
        scores: student_scores_for_assessment(uid, a)
      }
    end
    format_status(post_info)
  end

  def student_scores_for_assessment(uid, a)
    scores = Score.where(user: uid, assessment: a)
  end

  def assessment_th(course)
    open_th = '<th data-sortable=\'true\'>'
    close_th = '</th>'

    th = []
    course[:assessments].map do |aid|
      th_content =
        "<a href='/assessments/#{aid}/score' class='btn btn-xs btn-info'>S</a>"
      th << "#{open_th}#{th_content}#{close_th}"
    end
    th.join("\n").html_safe
  end

  def number_of_assessments(course)
    Assessment.where(section_id: course[:section]).count
  end

  def column_group(course)
    fn = calculate_first_name_width(course)
    ln = calculate_last_name_width(course)
    la = calculate_last_active_width(course)
    obj = calculate_objective_width(course)
    assessment = calculate_assessment_width(course)
    colgroup = []
    colgroup << '<colgroup>'
    colgroup << "  <col style='width: #{fn}%;'>"
    colgroup << "  <col style='width: #{ln}%;'>"
    colgroup << "  <col style='width: #{la}%;'>"
    colgroup << "  <col style='width: #{obj}%;'>"
    colgroup << "  <col style='width: #{obj}%;'>"
    colgroup << "  <col style='width: #{obj}%;'>"
    colgroup << "  <col style='width: #{obj}%;'>"
    for i in 1..(number_of_assessments(course)) do
      colgroup << "  <col style='width: #{assessment}%;'>"
    end
    colgroup << '</colgroup>'
    colgroup.join("\n").html_safe
  end

  def calculate_first_name_width(course)
    na = number_of_assessments(course)
    units = na + 4 + 3 + 6 # assessments + objectives + last_activity + names
    3.0 / units * 100
  end

  def calculate_last_name_width(course)
    na = number_of_assessments(course)
    units = na + 4 + 3 + 6 # assessments + objectives + last_activity + names
    3.0 / units * 100
  end

  def calculate_last_active_width(course)
    na = number_of_assessments(course)
    units = na + 4 + 3 + 6 # assessments + objectives + last_activity + names
    3.0 / units * 100
  end

  def calculate_objective_width(course)
    na = number_of_assessments(course)
    units = na + 4 + 3 + 6 # assessments + objectives + last_activity + names
    1.0 / units * 100
  end

  def calculate_assessment_width(course)
    na = number_of_assessments(course)
    units = na + 4 + 3 + 6 # assessments + objectives + last_activity + names
    # 1.0 / units * 100
    4.0
  end

  def objective_summary(uid, course)
    '<td></td><td></td><td></td><td></td>'.html_safe
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
        if Score.where(user: post.user, assessment: aid).count ==
          Assessment.find(aid).strands.count
            status << 'scored'
        else
          status << 'partially-scored'
        end
      end
    else
      status << 'unpublished'
      status << unless post.body.blank? && post.title.blank?
                  'started'
                else
                  'not-started'
      end
    end
    status << 'empty' if post.body.blank?
    status.join(' ')
  end

  def last_seen(uid)
    last = User.find(uid).active_today? ? 'today' : 'long-time-ago'
    "<span class=\"#{last} status\"></span>".html_safe
  end

  def unclassified_posts(uid)
    how_many = Post.where(user: uid, assessment: nil).count
    css = 'red-border' if how_many > 0
    "<span class=\"status unclassified-posts #{css}\"><span class=\"count\">#{how_many}</span></span>".html_safe
  end

  def format_status(pi)
    annunicator_style = ' status'
    css = ''
    href = ''
    title = ''
    status = pi.map do |info|
      if info[:posts][0][:pid].nil?
        if info[:scores].empty?
          href = '#'
          css = 'not-started' + annunicator_style
        else
          # Assignment not turned in, scored as 0 (persumably).
          href = '#'  # Make this a popover explaining how to reassess.
          css = 'scored-missing' + annunicator_style
        end
      else
        css = info[:posts][0][:status] + annunicator_style
        href = user_post_path(info[:uid], info[:posts][0][:pid])
      end
      title = "#{info[:a_title]}\n#{info[:posts][0][:title]}".html_safe

      "<td><a href=\"#{href}\" title=\"#{title}\" class=\"#{css}\">&nbsp;</a></td>"
    end.join.html_safe
    status
  end
end
