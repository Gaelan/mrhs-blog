class CommentPolicy < ApplicationPolicy
  alias comment record
  class Scope < Scope
    def resolve
      # XXX SQL-level private filtering.
    end
  end

  def show?
    # XXX Remove in favor of automatic scope-based show? mehod
    user.teacher? || user == comment.commentable.user
  end

  def create?
    true
  end

  def update?
    user.teacher? || user == comment.user
  end

  def create_private?
    user.teacher?
  end

  def permitted_attributes
    if create_private?
      [:commentable_type, :commentable_id, :body, :private]
    else
      [:commentable_type, :commentable_id, :body]
    end
  end
end
