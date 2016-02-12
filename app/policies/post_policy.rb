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
    allowed?
  end

  def destroy?
    allowed?
  end

  def user_index?
    #allowed?
    true
  end

  def index?
    true
  end
end
