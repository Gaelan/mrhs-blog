# Post policy
#
class PostPolicy < ApplicationPolicy
  alias_method :post, :record

  class Scope < Scope
    def resolve
      if user.teacher?
        scope
      else
        scope.where(published: true).or(scope.where(user: user))
      end
    end
  end

  def owner?
    post.user == user
  end

  def create?
    owner?
  end

  def update?
    owner? || user.teacher?
  end

  def destroy?
    owner? || user.teacher?
  end

  def index?
    true
  end
end
