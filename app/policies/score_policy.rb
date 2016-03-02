#
class ScorePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def allowed?
    binding.pry
    user.teacher? || user.admin?
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

  def index?
    allowed?
  end
end
