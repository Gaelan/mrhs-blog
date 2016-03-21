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
    Score.where(user: uid, assessment: a)
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
    # na = number_of_assessments(course)
    # units = na + 4 + 3 + 6 # assessments + objectives + last_activity + names
    # 1.0 / units * 100
    4.0
  end

  def objective_summary(uid, course)
    os = collect_objective_info(uid, course).map do |oi|
      {
        objective: summarize_objective(uid, oi)
      }
    end
    format_objective_summary(os)
  end

  def collect_objective_info(uid, course)
    Course.find(course[:course]).objectives.map do |o|
      {
        info: o,
        strands: o.strands.map do |s|
          {
            info: s,
            assessments: s.assessments.where(section: course[:section]).map do |a|
              {
                assessment: a,
                scores: Score.where(user: uid, strand: s, assessment: a)
              }
            end
          }
        end
      }
    end
  end

  def format_objective_summary(os)
    os.map do |o|
      # For each objective.
      score = 0.0
      scored_strands = 0.0
      unless objective_has_assessments(o) == true
        css_class = '\'not-assessed-yet\''
        score = 'NA'
        # tooltip = "No assessments yet for this objective."
      else
        o[:objective][:strands].map do |s|
          # For each strand.
          unless s[:score][:roll_up_score].nil?
            score += s[:score][:roll_up_score].to_f
            scored_strands += 1
          end
          scored_strands > 0 ? score = score / scored_strands : 0.0
        end
        css_class = case
                    when score <= 1.0
                      'limited-knowledge'
                    when score <= 2.0
                      'adequate-knowledge'
                    when score <  6.0
                      'substantial-knowledge'
                    else
                      'excellent-knowledge'
                    end
      end
      "<td class=#{css_class}><strong>#{score}</strong></td>"
    end.join.html_safe
  end

  def objective_has_assessments(o)
    if o[:objective][:strands].map { |st| st[:score][:assessments] }.sum == 0
      false
    else
      true
    end
  end

  def summarize_objective(uid, objective)
    {
      info: objective[:info],
      strands: objective[:strands].map do |s|
        {
          info: s[:info],
          score: strand_score(uid, s)
        }
      end
    }
  end

  def strand_score(uid, s)
    {
      assessments: s[:assessments].count,
      posts: count_posts_for_strand(uid, s),
      scores: times_assessed(s),
      max_possible_score: max_possible_score(s),
      raw_score: raw_score(s),
      roll_up_method: 'roll_up_average',
      roll_up_score: roll_up_average(s)
    }
  end

  def count_posts_for_strand(uid, s)
    # TODO: get an array of assessment_ids for this strand.
    # Post.where(user: uid, assessment: [])
    'Not calculated yet'
  end

  def times_assessed(s)
    s[:assessments].sum { |a| a[:scores].count }
  end

  def max_possible_score(s)
    if s[:assessments].count == 0
      nil
    else
      s[:assessments].sum { |a| a[:assessment].value }
    end
  end

  def raw_score(s)
    if s[:assessments].count == 0
      # Not assessed yet.
      nil
    else
      # Nil of not yet scored, else score value.
      s[:assessments].sum { |a| a[:scores].empty? ? 0 : (a[:scores].sum &:score) }
    end
  end

  def roll_up_average(s)
    # TODO: should not be hard coding the MYP scale (8.0) here.
    if times_assessed(s) == 0
      nil
    else
      raw_score(s).to_f / max_possible_score(s).to_f * 8.0 # XXX
    end
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
          href = '#' # Make this a popover explaining how to reassess.
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
