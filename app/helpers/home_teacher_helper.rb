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
        status: posts.assessment_status(a)
      }
    end
    binding.pry
    status
  end

  def assessment_status(id)
    binding.pry
  end
end
