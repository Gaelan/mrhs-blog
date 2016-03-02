#
class ScorePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def allowed?
    # TODO: control who can see scores. Make sure student scores are private.
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
