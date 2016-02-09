# Post policy
#
class PostPolicy < ApplicationPolicy
  alias_method :post, :record

  class Scope < Scope
    def resolve
      if user.teacher? || user.admin?
        scope
      else
        scope.where(published: true).or(scope.where(user: user))
      end
    end
  end

  def allowed?
    post.user == user || user.teacher? || user.admin?
  end

  def create?
    allowed?
  end

  def update?
    allowed? || user.teacher?
  end

  def destroy?
    allowed? || user.teacher?
  end

  def index?
    true
  end
end
