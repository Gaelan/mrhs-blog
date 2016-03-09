module UsersHelper
  # Return markup for user annunciator.
  def last_active(user)
    if user.last_active_time
      status = user.active_today? ? 'success' : 'danger'
      [time_ago_in_words(user.last_active_time) + ' ago', { class: status }]
    else
      ['Never', { class: 'danger' }]
    end
  end

  # Return markup for a published posts count.
  def post_count(user)
    published = user.posts.published.count
    unpublished = user.posts.unpublished.count
    posts_due_to_date = user.assessments.count

    posts = "#{published}/#{unpublished} of #{posts_due_to_date}"

    if user.posts.published.count == 0
      [posts, { class: 'danger' }]
    else
      posts
    end
  end
end
