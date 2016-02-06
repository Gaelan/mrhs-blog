class PostPolicy < ApplicationPolicy
  alias post record

  class Scope < Scope
    def resolve
      scope.where(published: true).or(scope.where(user: user))
    end
  end

  def is_owner?
    post.user == user
  end

  def create?
    is_owner?
  end

  def update?
    is_owner?
  end

  def destroy?
    is_owner?
  end

  def index?
    true
  end
end
